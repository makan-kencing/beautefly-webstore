package com.lavacorp.beautefly.webstore.admin.product.dto;

import java.io.Serializable;
import java.util.List;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.product.entity.Product}
 */
public record DeleteProductDTO(List<Integer> id) implements Serializable {
}