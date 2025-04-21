package com.lavacorp.beautefly.webstore.cart.dto;

import java.io.Serializable;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.cart.entity.CartProduct}
 */
public record SetCartProductDTO(
        int productId,
        int quantity
) implements Serializable {
}