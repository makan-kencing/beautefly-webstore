package com.lavacorp.beautefly.webstore.cart.dto;

import com.lavacorp.beautefly.webstore.product.entity.Product;

import java.math.BigDecimal;

public record CartItemDTO(Product product, int quantity, BigDecimal subtotal) {
}
