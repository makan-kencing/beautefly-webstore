package com.lavacorp.beautefly.webstore.product.dto;

public record ProductSearchContextDTO(
        PaginatedResult<ProductSearchResultDTO> page,
        ProductSearchDTO search
) {
}
