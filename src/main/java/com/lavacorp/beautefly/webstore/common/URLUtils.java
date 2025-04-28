package com.lavacorp.beautefly.webstore.common;

import lombok.experimental.UtilityClass;

import java.net.MalformedURLException;
import java.net.URL;

@UtilityClass
public class URLUtils {
    /**
     * Return the base path of the url.
     * `https://www.example.com/path?query=value` -> `https://www.example.com
     */
    @SuppressWarnings("JavadocLinkAsPlainText")
    public static String getBaseURL(String fullUrl) {
        try {
            var url = new URL(fullUrl);
            var protocol = url.getProtocol();
            var authority = url.getAuthority();

            return String.format("%s://%s", protocol, authority);
        } catch (MalformedURLException e) {
            throw new RuntimeException(e);
        }
    }
}
