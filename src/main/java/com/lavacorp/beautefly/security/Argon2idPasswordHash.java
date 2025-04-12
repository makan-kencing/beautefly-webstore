package com.lavacorp.beautefly.security;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Named;
import jakarta.security.enterprise.identitystore.PasswordHash;
import org.springframework.security.crypto.argon2.Argon2PasswordEncoder;

import java.util.Arrays;
import java.util.Map;

@ApplicationScoped
@Named("Argon2idPasswordHash")
public class Argon2idPasswordHash implements PasswordHash {
    private static final int SALT_LENGTH = 16;
    private static final int ITERATIONS = 2;
    private static final int MEMORY_LIMIT = 66536;
    private static final int HASH_LENGTH = 32;
    private static final int PARALLELISM = 1;

    private final Argon2PasswordEncoder encoder = new Argon2PasswordEncoder(
            SALT_LENGTH,
            HASH_LENGTH,
            PARALLELISM,
            MEMORY_LIMIT,
            ITERATIONS
    );

    @Override
    public void initialize(Map<String, String> parameters) {
    }

    @Override
    public String generate(char[] password) {
        return encoder.encode(Arrays.toString(password));
    }

    @Override
    public boolean verify(char[] password, String hashedPassword) {
        return encoder.matches(Arrays.toString(password), hashedPassword);
    }
}
