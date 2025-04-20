package com.lavacorp.beautefly.webstore.file.converter;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

import java.net.URI;

@Converter(autoApply = true)
public class URIConverter implements AttributeConverter<URI, String> {
    @Override
    public String convertToDatabaseColumn(URI value) {
        return value.toString();
    }

    @Override
    public URI convertToEntityAttribute(String value) {
        return URI.create(value);
    }
}
