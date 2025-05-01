package com.lavacorp.beautefly.webstore.rating.dto;

import java.util.Map;

public record RatingStatsDTO(
        long total,
        double average,
        Map<Integer, Integer> counts
) {
}
