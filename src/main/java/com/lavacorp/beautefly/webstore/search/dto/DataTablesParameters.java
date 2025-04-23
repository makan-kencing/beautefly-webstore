package com.lavacorp.beautefly.webstore.search.dto;

import com.fasterxml.jackson.annotation.JsonAlias;

import java.util.List;

public record DataTablesParameters(
        int draw,
        List<Column> columns,
        List<Order> order,
        int start,
        int length,
        Search search,
        @JsonAlias("_") long _a
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
        public enum Direction {
            asc, desc
        }
    }
}
