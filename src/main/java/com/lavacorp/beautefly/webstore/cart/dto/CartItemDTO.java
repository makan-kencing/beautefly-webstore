package com.lavacorp.beautefly.webstore.cart.dto;

import com.lavacorp.beautefly.webstore.product.entity.Product;

public record CartItemDTO(Product product, int quantity) {
}
