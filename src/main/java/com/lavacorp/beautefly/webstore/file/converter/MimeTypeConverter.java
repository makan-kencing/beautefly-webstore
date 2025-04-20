package com.lavacorp.beautefly.webstore.file.converter;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;
import org.apache.tika.config.TikaConfig;
import org.apache.tika.metadata.Metadata;
import org.apache.tika.mime.MediaType;
import org.apache.tika.mime.MimeType;
import org.apache.tika.mime.MimeTypeException;
import org.apache.tika.mime.MimeTypes;
import org.hibernate.type.SerializationException;

import java.io.IOException;
import java.io.InputStream;

@Converter(autoApply = true)
public class MimeTypeConverter implements AttributeConverter<MimeType, String> {
    private final static MimeTypes mimeRepository = TikaConfig.getDefaultConfig().getMimeRepository();

    @Override
    public String convertToDatabaseColumn(MimeType value) {
        return value.toString();
    }

    @Override
    public MimeType convertToEntityAttribute(String value) {
        try {
            return mimeRepository.forName(value);
        } catch (MimeTypeException e) {
            throw new SerializationException("Could not infer " + value + " as MimeType", e);
        }
    }

    public static MimeType toMimeType(String value) throws MimeTypeException {
        return mimeRepository.forName(value);
    }

    public static MimeType toMimeType(MediaType mediaType) throws MimeTypeException {
        return toMimeType(mediaType.toString());
    }

    public static MediaType inferMediaType(InputStream stream) throws IOException {
        return mimeRepository.detect(stream, new Metadata());
    }
}
