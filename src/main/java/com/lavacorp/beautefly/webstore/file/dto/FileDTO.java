package com.lavacorp.beautefly.webstore.file.dto;

import com.lavacorp.beautefly.webstore.file.entity.File;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.io.Serializable;

/**
 * DTO for {@link File}
 */
public record FileDTO(
        int id,
        String filename,
        File.FileType type
) implements Serializable {
}