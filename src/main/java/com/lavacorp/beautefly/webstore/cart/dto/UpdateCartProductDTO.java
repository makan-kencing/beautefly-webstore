package com.lavacorp.beautefly.webstore.cart.dto;

import java.io.Serializable;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.cart.entity.CartProduct}
 */
public record UpdateCartProductDTO(
        int productId,
        int quantity,
        Action action
) implements Serializable {
    public enum Action {
        INCREMENT,
        SET,
        DECREMENT
    }
}