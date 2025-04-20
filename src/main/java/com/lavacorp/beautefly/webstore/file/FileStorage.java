package com.lavacorp.beautefly.webstore.file;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.nio.file.Files;

public interface FileStorage {
    String save(byte[] data, String extension) throws IOException;

    default String save(File file, String extension) throws IOException {
        return save(Files.readAllBytes(file.toPath()), extension);
    }

    boolean delete(String filename);

    public URI resolveUrl(String filename);
}
