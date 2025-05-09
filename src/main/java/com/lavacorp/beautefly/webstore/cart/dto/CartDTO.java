package com.lavacorp.beautefly.webstore.cart.dto;

import java.math.BigDecimal;
import java.util.List;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.cart.entity.Cart}
 */
public record CartDTO(
        int id,
        List<CartItemDTO> items,
        BigDecimal subtotal,
        BigDecimal shippingCost,
        boolean isShippingDiscounted,
        BigDecimal estimatedTax,
        BigDecimal total,
        int selectedAddressId
) {
}
