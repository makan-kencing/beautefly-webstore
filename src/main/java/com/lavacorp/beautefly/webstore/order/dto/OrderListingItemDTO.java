package com.lavacorp.beautefly.webstore.order.dto;

import com.lavacorp.beautefly.webstore.order.entity.SalesOrderProduct;

import java.math.BigDecimal;
import java.time.Instant;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.order.entity.SalesOrderProduct}
 */
public record OrderListingItemDTO(
        int quantity,
        SalesOrderProduct.OrderProductStatus status,
        BigDecimal unitPrice,
        BigDecimal total
) {
}
