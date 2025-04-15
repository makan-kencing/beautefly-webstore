package com.lavacorp.beautefly.util.converter;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;
import lombok.extern.log4j.Log4j2;

import java.awt.*;

@Converter(autoApply = true)
@Log4j2
public class ColorConverter implements AttributeConverter<Color, String> {
    @Override
    public String convertToDatabaseColumn(Color attribute) {
        String hex = "#" + Integer.toHexString(attribute.getRGB()).substring(0,6);
        log.info("Convert from {} to hex {}", attribute, hex);
        return hex;
    }

    @Override
    public Color convertToEntityAttribute(String dbData) {
        Color color = Color.decode(dbData);
        log.info("Convert from hex {} to {}", dbData, color);
        return color;
    }
}
