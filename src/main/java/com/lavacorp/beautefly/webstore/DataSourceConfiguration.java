package com.lavacorp.beautefly.webstore;

import jakarta.annotation.Resource;
import jakarta.annotation.sql.DataSourceDefinition;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.inject.Produces;

import javax.sql.DataSource;

@DataSourceDefinition(
        name = "java:app/jdbc/beauteflyds",
        className = "com.lavacorp.beautefly.datasource.ELConfigurableDataSource",
        url = "ENV(db.url)",
        user = "ENV(db.user)",
        password = "ENV(db.password)",
        properties = {
                "driverClassName=ENV(db.driver)"
        })
@ApplicationScoped
public class DataSourceConfiguration {
    @Resource(lookup="java:app/jdbc/beauteflyds")
    private DataSource dataSource;

    @Produces
    public DataSource getDatasource() {
        return dataSource;
    }
}

