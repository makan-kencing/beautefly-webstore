package com.lavacorp.beautefly.webstore.file.dto;

import com.lavacorp.beautefly.webstore.file.entity.FileUpload;
import org.apache.tika.mime.MimeType;

import java.io.Serializable;
import java.net.URI;

/**
 * DTO for {@link FileUpload}
 */
public record FileUploadDTO(
        int id,
        String filename,
        MimeType type,
        URI url
) implements Serializable {
}