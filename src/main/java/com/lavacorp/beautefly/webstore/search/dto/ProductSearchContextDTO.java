package com.lavacorp.beautefly.webstore.search.dto;

import com.lavacorp.beautefly.webstore.common.dto.PaginatedResult;

public record ProductSearchContextDTO(
        PaginatedResult<ProductSearchResultDTO> page,
        ProductSearchDTO search
) {
}
