package com.lavacorp.beautefly.util.datasource;

import com.lavacorp.beautefly.util.env.ConfigurableEnvironment;
import com.lavacorp.beautefly.util.env.el.ELExpressionEvaluator;

/**
 * This is a configurable DataSource that is capable of looking up database
 * connection information from the environment / profiles config properties as
 * process values as EL expressions.
 */
public class ELConfigurableDataSource extends ConfigurableDataSource {

    public ELConfigurableDataSource() {
        super(
                new ConfigurableEnvironment(
                        new String[]{"application", "datasource", "security"},
                        new ELExpressionEvaluator()
                ),
                new ELExpressionEvaluator()
        );
    }
}
