package com.lavacorp.beautefly.webstore.cart.dto;

import java.math.BigDecimal;
import java.util.List;

public record CartDTO(
        List<CartItemDTO> items,
        BigDecimal subtotal,
        BigDecimal shippingCost,
        boolean isShippingDiscounted,
        BigDecimal estimatedTax,
        BigDecimal total) {
}
