package com.lavacorp.beautefly.webstore.file;

import com.lavacorp.beautefly.webstore.file.entity.File;
import jakarta.annotation.Nullable;

import java.io.IOException;
import java.nio.file.Files;

public interface FileStorage {
    @Nullable
    File save(byte[] data, String extension);

    default @Nullable File save(java.io.File file, String extension) {
        try {
            return save(Files.readAllBytes(file.toPath()), extension);
        } catch (IOException e) {
            return null;
        }
    }

    boolean delete(File file);
}
