package com.lavacorp.beautefly.util.env;

// https://github.com/mpuening/learn-jakartaee/blob/master/learn-jakartaee-env/src/main/java/io/github/learnjakartaee/env/ExpressionEvaluator.java
public interface ExpressionEvaluator {
    /**
     * @param description Human-readable description of expression
     * @param expression  expression to evaluate
     */
    String evaluateExpression(String description, String expression);
}