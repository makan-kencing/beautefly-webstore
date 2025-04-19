package com.lavacorp.beautefly.webstore.file;

import com.lavacorp.beautefly.webstore.account.entity.UserAccount;
import com.lavacorp.beautefly.webstore.file.entity.FileUpload;
import com.lavacorp.beautefly.webstore.file.dto.FileDTO;
import com.lavacorp.beautefly.webstore.file.mapper.FileUploadMapper;
import com.lavacorp.beautefly.webstore.file.santiizer.DocumentSanitizer;
import com.lavacorp.beautefly.webstore.file.santiizer.ImageDocumentSanitizer;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.ws.rs.core.EntityPart;
import lombok.extern.log4j.Log4j2;
import org.apache.tika.config.TikaConfig;
import org.apache.tika.metadata.Metadata;
import org.apache.tika.mime.MediaType;
import org.apache.tika.mime.MimeType;
import org.apache.tika.mime.MimeTypeException;
import org.apache.tika.mime.MimeTypes;
import org.hibernate.SessionFactory;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URI;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.nio.file.StandardOpenOption;

@ApplicationScoped
@Log4j2
public class FileService {
    private final static TikaConfig tikaConfig = TikaConfig.getDefaultConfig();
    private final static MimeTypes mimeRepository = tikaConfig.getMimeRepository();

    @PersistenceUnit
    private EntityManagerFactory emf;

    @Inject
    private FileUploadMapper fileUploadMapper;

    @Inject
    private FileStorage fileStorage;

    public FileDTO processFile(@NotNull EntityPart part, UserAccount userAccount) {
        java.io.File tmpFile = createTempFile(part);
        if (tmpFile == null)
            return null;

        MediaType mediaType;
        try {
            var inputStream = new FileInputStream(tmpFile);
            var bufferedInputStream = new BufferedInputStream(inputStream);
            mediaType = mimeRepository.detect(bufferedInputStream, new Metadata());
        } catch (IOException e) {
            log.error("Error detecting mimetype", e);
            return null;
        }

        MimeType mimeType;
        try {
            mimeType = mimeRepository.forName(mediaType.toString());
        } catch (MimeTypeException e) {
            log.error(e);
            return null;
        }

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
        file.setAccount(userAccount);

        emf.unwrap(SessionFactory.class)
                .openStatelessSession()
                .insert(file);

        return fileUploadMapper.toFileUploadDTO(file);
    }

    public URI resolveHref(String contextPath, String filename) {
        return URI.create(contextPath).resolve(fileStorage.resolveHref(filename));
    }

    /**
     * Utility methods to save input file into a temp file
     *
     * @param part the input file multipart
     */
    private static @Nullable java.io.File createTempFile(@NotNull EntityPart part) {
        var fileStream = part.getContent();
        if (fileStream == null)
            return null;

        java.io.File tmpFile;
        try {
            tmpFile = java.io.File.createTempFile("uploaded-", null);
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

    private static boolean makeSafe(java.io.File file, MediaType mediaType) {
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
}
