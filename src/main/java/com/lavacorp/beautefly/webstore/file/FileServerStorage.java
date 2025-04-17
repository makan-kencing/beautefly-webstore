package com.lavacorp.beautefly.webstore.file;

import com.lavacorp.beautefly.webstore.file.entity.File;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.xml.bind.DatatypeConverter;
import lombok.extern.log4j.Log4j2;
import org.jetbrains.annotations.Nullable;

import java.io.IOException;
import java.net.URI;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@ApplicationScoped
@Log4j2
public class FileServerStorage implements FileStorage {
    private static final MessageDigest digester;

    static {
        try {
            digester = MessageDigest.getInstance("sha-256");
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    static Path saveDir = Path.of("/var/www/data/media");
    static URI baseHref = URI.create("/media");

    @Override
    public @Nullable File save(byte[] data, String extension) {
        var hash = DatatypeConverter.printHexBinary(digester.digest());
        var filename = hash + "." + extension;

        Path filepath = saveDir.resolve(hash + extension);

        try {
            Files.write(filepath, data);
        } catch (IOException e) {
            log.error("Error saving file to {}", filepath, e);
            return null;
        }

        var file = new File();
        file.setFilename(filename);
        // TODO: change so default is not always image. ETA: never
        file.setType(File.FileType.IMAGE);

        return file;
    }

    @Override
    public boolean delete(File file) {
        Path localPath = saveDir.resolve(file.getFilename());

        return localPath.toFile().delete();
    }

    public static URI resolveHyperlink(String filename) {
        return baseHref.resolve(filename);
    }
}
