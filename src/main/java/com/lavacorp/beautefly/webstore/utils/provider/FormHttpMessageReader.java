package com.lavacorp.beautefly.webstore.utils.provider;

import com.fasterxml.jackson.databind.ObjectMapper;
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
import java.net.URLDecoder;
import java.util.Collections;
import java.util.HashMap;
import java.util.StringTokenizer;

import static java.nio.charset.StandardCharsets.UTF_8;

//  https://github.com/eclipse-ee4j/glassfish/blob/master/nucleus/admin/rest/rest-service/src/main/java/org/glassfish/admin/rest/readers/RestModelReader.java
@Provider
@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
public class FormHttpMessageReader<T> implements MessageBodyReader<T> {
    private final ObjectMapper mapper = new ObjectMapper();

    @Override
    public boolean isReadable(Class<?> clazz, Type type, Annotation[] annotations, MediaType mediaType) {
        if (clazz.isAssignableFrom(Form.class) || clazz.isAssignableFrom(Collections.class))
            return false;
        return mediaType.isCompatible(MediaType.APPLICATION_FORM_URLENCODED_TYPE);
    }

    @Override
    public T readFrom(
            Class<T> clazz,
            Type type,
            Annotation[] annotations,
            MediaType mediaType,
            MultivaluedMap<String, String> multivaluedMap,
            InputStream inputStream
    ) throws IOException, WebApplicationException {
        String charset = mediaType.getParameters()
                .getOrDefault(MediaType.CHARSET_PARAMETER, UTF_8.name());
        String formData = new String(inputStream.readAllBytes(), charset);

        var map = new HashMap<String, String>();
        var tokenizer = new StringTokenizer(formData, "&");
        String token;
        while (tokenizer.hasMoreTokens()) {
            token = tokenizer.nextToken();
            int idx = token.indexOf('=');
            if (idx < 0) {
                map.put(URLDecoder.decode(token, UTF_8), null);
            } else if (idx > 0) {
                map.put(URLDecoder.decode(token.substring(0, idx), UTF_8), URLDecoder.decode(token.substring(idx + 1), UTF_8));
            }
        }
        return mapper.convertValue(map, clazz);
    }
}