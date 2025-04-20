package com.lavacorp.beautefly.webstore.file;

import com.lavacorp.beautefly.util.env.ConfigurableEnvironment;
import com.lavacorp.beautefly.util.env.el.ELExpressionEvaluator;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.xml.bind.DatatypeConverter;
import lombok.extern.log4j.Log4j2;

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
    private static final Path outputDir;
    private static final URI baseHref;

    static {
        try {
            digester = MessageDigest.getInstance("sha-256");
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }

        var evaluator = new ELExpressionEvaluator();
        var environment = new ConfigurableEnvironment(evaluator);

        outputDir = Path.of(environment.getProperty("Output Media Directory", "filestorage.media-dir"));
        baseHref = URI.create(environment.getProperty("URL Base URI", "filestorage.base-uri"));

        try {
            Files.createDirectories(outputDir);
        } catch (IOException e) {
            log.error("Error creating output directory {}", outputDir, e);
            throw new RuntimeException(e);
        }
    }

    @Override
    public String save(byte[] data, String extension) throws IOException {
        var hash = DatatypeConverter.printHexBinary(digester.digest(data));
        var filename = hash + extension;
        Path filepath = outputDir.resolve(filename);

        Files.write(filepath, data);

        return filename;
    }

    @Override
    public boolean delete(String filename) {
        Path localPath = outputDir.resolve(filename);

        return localPath.toFile().delete();
    }

    public URI resolveUrl(String filename) {
        return baseHref.resolve(filename);
    }
}
