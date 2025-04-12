package com.lavacorp.beautefly.env.el;

import com.lavacorp.beautefly.env.ExpressionEvaluator;
import jakarta.el.ELProcessor;
import lombok.extern.log4j.Log4j2;

import java.util.Map;
import java.util.Properties;

// https://github.com/mpuening/learn-jakartaee/blob/master/learn-jakartaee-env/src/main/java/io/github/learnjakartaee/env/el/ELExpressionEvaluator.java
@Log4j2
public class ELExpressionEvaluator implements ExpressionEvaluator {

    private final ELProcessor processor;

    public ELExpressionEvaluator() {
        this.processor = new ELProcessor();
        processor.defineBean("env", getEnv());
        processor.defineBean("properties", getProperties());
    }

    @Override
    public String evaluateExpression(String description, String expression) {
        log.debug("Evaluate {}: {}", description, expression);
        return processor.eval(expression).toString();
    }

    public Map<String, String> getEnv() {
        return System.getenv();
    }

    public Properties getProperties() {
        return System.getProperties();
    }
}
