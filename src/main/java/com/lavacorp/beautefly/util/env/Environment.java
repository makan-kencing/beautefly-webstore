package com.lavacorp.beautefly.util.env;

// https://github.com/mpuening/learn-jakartaee/blob/master/learn-jakartaee-env/src/main/java/io/github/learnjakartaee/env/Environment.java
/**
 * Utility class used to look up properties in application.properties files and
 * also have support for profiles, such as unittest, local, and cloud
 * deployments. Values can be expressions that can be evaluated in various ways.
 * <p>
 * This class takes some inspiration from the Spring framework.
 */
public interface Environment {

    public static final String PROFILES_ENV_VAR_NAME = "APP_PROFILES_ACTIVE";
    public static final String PROFILES_PROPERTY_NAME = "app.profiles.active";

    public static String getActiveProfiles() {
        return System.getenv()
                .getOrDefault(
                        PROFILES_ENV_VAR_NAME,
                        System.getProperty(PROFILES_PROPERTY_NAME, "")
                );
    }

    /**
     * Default impl is to interpret expression as the value if not a property
     *
     * @param description Human-readable description of property (good for debugging)
     * @param key         Property key / name
     */
    default String getProperty(String description, String key) {
        return getProperty(description, key, null);
    }

    /**
     * @param description  Human-readable description of property (good for debugging)
     * @param key          Property key / name
     * @param defaultValue Default value to return when property is not found
     */
    String getProperty(String description, String key, String defaultValue);
}