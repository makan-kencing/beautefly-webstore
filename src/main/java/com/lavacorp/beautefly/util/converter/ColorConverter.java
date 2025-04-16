package com.lavacorp.beautefly.util.converter;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;
import lombok.extern.log4j.Log4j2;

import java.awt.*;

@Converter(autoApply = true)
public class ColorConverter implements AttributeConverter<Color, String> {
    @Override
    public String convertToDatabaseColumn(Color attribute) {
        return "#" + Integer.toHexString(attribute.getRGB()).substring(0, 6);
    }

    @Override
    public Color convertToEntityAttribute(String dbData) {
        return Color.decode(dbData);
    }
}
