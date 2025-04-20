package com.lavacorp.beautefly.webstore.file.exception;

import jakarta.annotation.Nullable;
import lombok.Getter;
import org.apache.tika.mime.MimeType;

@Getter
public class UnsupportedFileFormatException extends IllegalArgumentException {
    @Nullable private final MimeType mimeType;

    public UnsupportedFileFormatException(String message, @Nullable MimeType mimeType) {
        super(message);
        this.mimeType = mimeType;
    }

    public UnsupportedFileFormatException(String message) {
        this(message, null);
    }
}
