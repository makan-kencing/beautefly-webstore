package com.lavacorp.beautefly.webstore.file;

import jakarta.annotation.Nullable;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.nio.file.Files;

public interface FileStorage {
    @Nullable
    String save(byte[] data, String extension);

    default @Nullable String save(File file, String extension) {
        try {
            return save(Files.readAllBytes(file.toPath()), extension);
        } catch (IOException e) {
            return null;
        }
    }

    boolean delete(String filename);

    public URI resolveHref(String filename);
}
