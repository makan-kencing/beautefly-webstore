package com.lavacorp.beautefly.webstore.cart.dto;

import com.lavacorp.beautefly.webstore.search.dto.ProductSearchDTO;

import java.math.BigDecimal;

public record CartItemDTO(
        ProductSearchDTO product,
        int quantity,
        BigDecimal subtotal
) {
}
