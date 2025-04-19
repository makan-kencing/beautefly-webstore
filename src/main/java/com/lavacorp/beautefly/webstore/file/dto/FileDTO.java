package com.lavacorp.beautefly.webstore.file.dto;

import com.lavacorp.beautefly.webstore.file.FileServerStorage;
import com.lavacorp.beautefly.webstore.file.entity.FileUpload;

import java.io.Serializable;
import java.net.URI;

/**
 * DTO for {@link FileUpload}
 */
public record FileDTO(
        int id,
        String filename,
        FileUpload.FileType type,
        URI href
) implements Serializable {
}