package com.lavacorp.beautefly.webstore.file;

import com.lavacorp.beautefly.webstore.account.entity.UserAccount;
import com.lavacorp.beautefly.webstore.file.converter.MimeTypeConverter;
import com.lavacorp.beautefly.webstore.file.dto.FileUploadDTO;
import com.lavacorp.beautefly.webstore.file.entity.FileUpload;
import com.lavacorp.beautefly.webstore.file.exception.UnsupportedFileFormatException;
import com.lavacorp.beautefly.webstore.file.mapper.FileUploadMapper;
import com.lavacorp.beautefly.webstore.file.santiizer.DocumentSanitizer;
import com.lavacorp.beautefly.webstore.file.santiizer.ImageDocumentSanitizer;
import com.lavacorp.beautefly.webstore.security.SecurityService;
import jakarta.annotation.Nullable;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import jakarta.validation.constraints.NotNull;
import jakarta.ws.rs.core.EntityPart;
import lombok.extern.log4j.Log4j2;
import org.apache.tika.mime.MediaType;
import org.apache.tika.mime.MimeType;
import org.apache.tika.mime.MimeTypeException;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.nio.file.StandardOpenOption;

@Log4j2
@Transactional
@ApplicationScoped
public class FileService {

    @Inject
    private SecurityService securityService;

    @Inject
    private FileUploadMapper fileUploadMapper;

    @Inject
    private FileStorage fileStorage;

    public FileUpload save(@NotNull EntityPart part, @Nullable UserAccount account) throws IOException, UnsupportedFileFormatException {
        File tmpFile = saveAsTempFile(part);

        // MimeRepository.detect requires InputStream with markSupported()
        var stream = new BufferedInputStream(Files.newInputStream(tmpFile.toPath()));
        MediaType mediaType = MimeTypeConverter.inferMediaType(stream);
        MimeType mimeType;
        try {
            mimeType = MimeTypeConverter.toMimeType(mediaType);
        } catch (MimeTypeException e) {
            safelyRemoveFile(tmpFile.toPath());
            throw new UnsupportedFileFormatException("Could not detect the file format of the uploaded document.");
        }

        boolean isSafe = makeSafe(tmpFile, mimeType);
        if (!isSafe) {
            safelyRemoveFile(tmpFile.toPath());
            throw new UnsupportedFileFormatException("Detection of an unsafe file upload or cannot sanitize uploaded document!", mimeType);
        }

        var filename = fileStorage.save(tmpFile, mimeType.getExtension());

        var file = new FileUpload();
        file.setFilename(part.getFileName().orElse(filename));
        file.setUrl(fileStorage.resolveUrl(filename));
        file.setType(mimeType);
        file.setAccount(account);

        return file;
    }

    public FileUploadDTO uploadFile(@NotNull EntityPart part, HttpServletRequest req) throws IOException, UnsupportedFileFormatException {
        var account = securityService.getUserAccountContext(req);

        var file = save(part, account);

        return fileUploadMapper.toFileUploadDTO(file);
    }

    /**
     * Utility methods to save input file into a temp file
     *
     * @param part the input file multipart
     */
    private static File saveAsTempFile(@NotNull EntityPart part) throws IOException {
        var tmpFile = File.createTempFile("uploaded-", null);

        try {
            Files.copy(part.getContent(), tmpFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            safelyRemoveFile(tmpFile.toPath());
            throw e;
        }

        return tmpFile;
    }

    @SuppressWarnings("SwitchStatementWithTooFewBranches")
    private static boolean makeSafe(File file, MimeType mimeType) {
        DocumentSanitizer documentSanitizer;
        return switch (mimeType.getType().getType()) {
            case "image" -> {
                documentSanitizer = new ImageDocumentSanitizer();
                yield documentSanitizer.madeSafe(file);
            }
            default -> throw new IllegalArgumentException("Unknown file type specified !");
        };
    }

    /**
     * Utility methods to safely remove a file
     *
     * @param p file to remove
     */
    private static void safelyRemoveFile(@NotNull Path p) throws IOException {
        try {
            // Remove temporary file
            Files.deleteIfExists(p);
        } catch (IOException e) {
            // If remove fail then overwrite content to sanitize it
            Files.writeString(p, "-", StandardOpenOption.CREATE);
        }
    }
}
