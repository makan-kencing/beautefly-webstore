package com.lavacorp.beautefly.webstore.cart.dto;

import com.lavacorp.beautefly.webstore.search.dto.ProductSearchResultDTO;

import java.math.BigDecimal;

public record CartItemDTO(
        ProductSearchResultDTO product,
        int quantity,
        BigDecimal subtotal
) {
}
