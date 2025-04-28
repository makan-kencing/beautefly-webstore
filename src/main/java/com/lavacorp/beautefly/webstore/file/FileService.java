package com.lavacorp.beautefly.webstore.file;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.file.converter.MimeTypeConverter;
import com.lavacorp.beautefly.webstore.file.dto.FileUploadDTO;
import com.lavacorp.beautefly.webstore.file.entity.FileUpload;
import com.lavacorp.beautefly.webstore.file.exception.UnsupportedFileFormatException;
import com.lavacorp.beautefly.webstore.file.mapper.FileUploadMapper;
import com.lavacorp.beautefly.webstore.file.sanitizer.DocumentSanitizer;
import com.lavacorp.beautefly.webstore.file.sanitizer.ImageDocumentSanitizer;
import com.lavacorp.beautefly.webstore.security.dto.AccountContextDTO;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.transaction.Transactional;
import jakarta.validation.constraints.NotNull;
import lombok.extern.log4j.Log4j2;
import org.apache.tika.mime.MediaType;
import org.apache.tika.mime.MimeType;
import org.apache.tika.mime.MimeTypeException;
import org.hibernate.SessionFactory;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.nio.file.StandardOpenOption;

@Log4j2
@Transactional
@ApplicationScoped
public class FileService {
    @PersistenceUnit
    private EntityManagerFactory emf;

    @Inject
    private FileUploadMapper fileUploadMapper;

    @Inject
    private FileStorage fileStorage;

    public FileUpload save(@NotNull InputStream stream, String filename) throws IOException, UnsupportedFileFormatException {
        File tmpFile = saveAsTempFile(stream);

        // MimeRepository.detect requires InputStream with markSupported()
        var tmpFileStream = new BufferedInputStream(Files.newInputStream(tmpFile.toPath()));
        MediaType mediaType = MimeTypeConverter.inferMediaType(tmpFileStream);
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

        var filehash = fileStorage.save(tmpFile, mimeType.getExtension());

        var file = new FileUpload();
        file.setHash(filehash);
        file.setFilename(filename != null ? filename : filehash);
        file.setUrl(fileStorage.resolveUrl(filehash));
        file.setType(mimeType);

        return file;
    }

    public FileUpload persist(FileUpload file) {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var existingFile = session.createSelectionQuery("from FileUpload where hash = :hash", FileUpload.class)
                .setParameter("hash", file.getHash())
                .getSingleResultOrNull();

        if (existingFile == null)
            session.insert(file);
        else {
            file = fileUploadMapper.updateMetadata(file, existingFile);
            session.update(file);
        }

        return file;
    }

    public FileUploadDTO uploadFile(@NotNull InputStream stream, String filename, AccountContextDTO user) throws IOException, UnsupportedFileFormatException {
        var file = save(stream, filename);

        var account = new Account();
        account.setId(user.id());

        file.setCreatedBy(account);
        
        file = persist(file);

        return fileUploadMapper.toFileUploadDTO(file);
    }

    /**
     * Utility methods to save input file into a temp file
     */
    private static File saveAsTempFile(@NotNull InputStream stream) throws IOException {
        var tmpFile = File.createTempFile("uploaded-", null);

        try {
            Files.copy(stream, tmpFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
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
