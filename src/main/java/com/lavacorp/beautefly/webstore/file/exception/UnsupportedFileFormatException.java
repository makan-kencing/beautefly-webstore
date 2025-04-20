package com.lavacorp.beautefly.webstore.file.exception;

import lombok.Getter;
import org.apache.tika.mime.MimeType;

@Getter
public class UnsupportedFileFormatException extends IllegalArgumentException {
    private final MimeType mimeType;

    public UnsupportedFileFormatException(String message, MimeType mimeType) {
        super(message);
        this.mimeType = mimeType;
    }
}
