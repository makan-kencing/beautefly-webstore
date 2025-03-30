package com.lavacorp.beautefly.webstore.utils;

// Code copied from https://github.com/exabrial/form-binding
// Rewritten to support Jakarta EE

import com.github.exabrial.formbinding.FormBindingReader;
import com.github.exabrial.formbinding.impl.DefaultFormBindingReader;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.WebApplicationException;
import jakarta.ws.rs.core.Form;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.MultivaluedMap;
import jakarta.ws.rs.ext.MessageBodyReader;
import jakarta.ws.rs.ext.Provider;

import java.io.IOException;
import java.io.InputStream;
import java.lang.annotation.Annotation;
import java.lang.reflect.Type;
import java.nio.charset.StandardCharsets;
import java.util.Collections;
import java.util.Scanner;

@Provider
@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
public class FormBindingMessageBodyReader<T> implements MessageBodyReader<T> {
    //    errors with The Java SPI system could not locate a FormBindingReader implementation
    //    private static final FormBindingReader reader = FormBinding.getReader();
    private static final FormBindingReader reader = new DefaultFormBindingReader();

    @Override
    public boolean isReadable(final Class<?> type, final Type genericType, final Annotation[] annotations, final MediaType mediaType) {
        return !type.isAssignableFrom(Form.class) && !type.isAssignableFrom(Collections.class)
                && mediaType.equals(MediaType.APPLICATION_FORM_URLENCODED_TYPE);
    }

    @Override
    public T readFrom(final Class<T> type, final Type genericType, final Annotation[] annotations, final MediaType mediaType,
                      final MultivaluedMap<String, String> httpHeaders, final InputStream entityStream) throws IOException, WebApplicationException {
        String input;
        try (Scanner scanner = new Scanner(entityStream, StandardCharsets.UTF_8)) {
            input = scanner.useDelimiter("\\A").next();
        }
        return reader.read(input, type);
    }
}