package com.lavacorp.beautefly.webstore.utils.producer;

import jakarta.enterprise.inject.Produces;
import jakarta.enterprise.inject.spi.InjectionPoint;
import jakarta.inject.Singleton;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;


@Singleton
public class LoggerProducer {
    @Produces
    public Logger getLogger(final InjectionPoint injectionPoint) {
        Class<?> clazz = injectionPoint.getMember()
                .getDeclaringClass();
        return LogManager.getLogger(clazz);
    }
}
