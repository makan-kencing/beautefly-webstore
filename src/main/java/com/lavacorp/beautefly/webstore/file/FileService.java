package com.lavacorp.beautefly.webstore.file;

import com.lavacorp.beautefly.webstore.file.entity.FileUpload;
import com.lavacorp.beautefly.webstore.file.dto.FileDTO;
import com.lavacorp.beautefly.webstore.file.mapper.FileUploadMapper;
import com.lavacorp.beautefly.webstore.file.santiizer.DocumentSanitizer;
import com.lavacorp.beautefly.webstore.file.santiizer.ImageDocumentSanitizer;
import com.lavacorp.beautefly.webstore.security.SecurityService;
import jakarta.annotation.Nullable;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import jakarta.validation.constraints.NotNull;
import jakarta.ws.rs.core.EntityPart;
import lombok.extern.log4j.Log4j2;
import org.apache.tika.config.TikaConfig;
import org.apache.tika.metadata.Metadata;
import org.apache.tika.mime.MediaType;
import org.apache.tika.mime.MimeType;
import org.apache.tika.mime.MimeTypeException;
import org.apache.tika.mime.MimeTypes;
import org.hibernate.SessionFactory;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URI;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.nio.file.StandardOpenOption;

@Log4j2
@Transactional
@ApplicationScoped
public class FileService {
    private final static TikaConfig tikaConfig = TikaConfig.getDefaultConfig();
    private final static MimeTypes mimeRepository = tikaConfig.getMimeRepository();

    @PersistenceUnit
    private EntityManagerFactory emf;

    @Inject
    private SecurityService securityService;

    @Inject
    private FileUploadMapper fileUploadMapper;

    @Inject
    private FileStorage fileStorage;

    public FileDTO uploadFile(
            @NotNull EntityPart part,
            HttpServletRequest req
    ) {
        var account = securityService.getUserAccountContext(req.getUserPrincipal());

        File tmpFile = createTempFile(part);
        if (tmpFile == null)
            return null;

        MediaType mediaType = inferMediaType(tmpFile);
        if (mediaType == null)
            return null;

        MimeType mimeType = convertToMimeType(mediaType);
        if (mimeType == null)
            return null;

        boolean isSafe = makeSafe(tmpFile, mediaType);
        if (!isSafe) {
            log.warn("Detection of an unsafe file upload or cannot sanitize uploaded document!");
            safelyRemoveFile(tmpFile.toPath());
            return null;
        }

        var filename = fileStorage.save(tmpFile, mimeType.getExtension());
        if (filename == null)
            return null;

        var file = new FileUpload();
        file.setFilename(filename);
        file.setType(FileUpload.FileType.fromMediaType(mediaType));
        file.setAccount(account);

        emf.unwrap(SessionFactory.class)
                .openStatelessSession()
                .insert(file);

        var href = resolveHref(req.getContextPath(), file.getFilename());
        return fileUploadMapper.toFileUploadDTO(file, href);
    }

    public URI resolveHref(String contextPath, String filename) {
        return URI.create(contextPath).resolve(fileStorage.resolveHref(filename));
    }

    /**
     * Utility methods to save input file into a temp file
     *
     * @param part the input file multipart
     */
    private static @Nullable File createTempFile(@NotNull EntityPart part) {
        var fileStream = part.getContent();
        if (fileStream == null)
            return null;

        File tmpFile;
        try {
            tmpFile = File.createTempFile("uploaded-", null);
        } catch (IOException e) {
            log.error("Cannot create temp file", e);
            return null;
        }

        try {
            Files.copy(fileStream, tmpFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            log.error("Failed to copy bytes", e);
            safelyRemoveFile(tmpFile.toPath());
            return null;
        }

        return tmpFile;
    }

    private static boolean makeSafe(File file, MediaType mediaType) {
        DocumentSanitizer documentSanitizer;
        return switch (mediaType.getType()) {
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
    private static void safelyRemoveFile(@NotNull Path p) {
        try {
            // Remove temporary file
            if (!Files.deleteIfExists(p))
                // If remove fail then overwrite content to sanitize it
                Files.writeString(p, "-", StandardOpenOption.CREATE);
        } catch (Exception e) {
            log.warn("Cannot safely remove file !", e);
        }
    }

    private static MediaType inferMediaType(File file) {
        try {
            var inputStream = new FileInputStream(file);
            var bufferedInputStream = new BufferedInputStream(inputStream);
            return mimeRepository.detect(bufferedInputStream, new Metadata());
        } catch (IOException e) {
            log.error("Error detecting mimetype", e);
            return null;
        }
    }

    private static MimeType convertToMimeType(MediaType mediaType) {
        try {
            return mimeRepository.forName(mediaType.toString());
        } catch (MimeTypeException e) {
            log.error(e);
            return null;
        }
    }
}
