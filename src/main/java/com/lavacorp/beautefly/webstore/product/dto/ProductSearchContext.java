package com.lavacorp.beautefly.webstore.product.dto;

import com.lavacorp.beautefly.webstore.product.entity.Product;

public record ProductSearchContext(
        PaginatedResult<Product> page,
        ProductSearchDTO search
) {
}
