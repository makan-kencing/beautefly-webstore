package com.lavacorp.beautefly.webstore.search.dto;

import com.fasterxml.jackson.annotation.JsonAlias;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;

import java.util.List;
import java.util.Map;

public record DataTablesParameters(
        int draw,
        List<Column> columns,
        List<Order> order,
        int start,
        int length,
        Search search,
        @JsonAnyGetter Map<String, String> properties
) {
    public record Search (
            String value,
            boolean regex
    ) {
    }

    public record Column(
            String data,
            String name,
            boolean searchable,
            boolean orderable,
            Search search
    ) {
    }

    public record Order(
            String column,
            Direction dir,
            String name
    ) {
    }

    @JsonAnySetter
    public void setProperty(String key, String value) {
        properties.put(key, value);
    }
}
