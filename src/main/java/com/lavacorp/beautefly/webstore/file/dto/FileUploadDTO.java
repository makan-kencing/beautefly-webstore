package com.lavacorp.beautefly.webstore.file.dto;

import com.lavacorp.beautefly.webstore.file.entity.FileUpload;
import com.lavacorp.beautefly.webstore.file.serializer.MimeTypeJsonSerializer;
import jakarta.json.bind.annotation.JsonbTypeSerializer;
import org.apache.tika.mime.MimeType;

import java.io.Serializable;
import java.net.URI;

/**
 * DTO for {@link FileUpload}
 */
public record FileUploadDTO(
        int id,
        String filename,
        @JsonbTypeSerializer(MimeTypeJsonSerializer.class) MimeType type,
        URI url
) implements Serializable {
}