package com.lavacorp.beautefly.webstore.file.serializer;

import jakarta.json.bind.serializer.JsonbSerializer;
import jakarta.json.bind.serializer.SerializationContext;
import jakarta.json.stream.JsonGenerator;
import org.apache.tika.mime.MimeType;

public class MimeTypeJsonSerializer implements JsonbSerializer<MimeType> {
    @Override
    public void serialize(MimeType value, JsonGenerator generator, SerializationContext context) {
        generator.write(value.getName());
    }
}
