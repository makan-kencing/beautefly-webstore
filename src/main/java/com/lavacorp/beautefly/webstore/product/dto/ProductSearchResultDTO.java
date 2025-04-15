package com.lavacorp.beautefly.webstore.product.dto;

public record ProductSearchResultDTO(
        PaginatedResult<ProductDTO> page,
        ProductSearchDTO search
) {
}
