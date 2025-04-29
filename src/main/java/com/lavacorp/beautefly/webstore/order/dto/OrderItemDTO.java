package com.lavacorp.beautefly.webstore.order.dto;

import com.lavacorp.beautefly.webstore.order.entity.SalesOrderProduct;
import com.lavacorp.beautefly.webstore.search.dto.ProductSearchResultDTO;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.Instant;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.order.entity.SalesOrderProduct}
 */
public record OrderItemDTO(
        ProductSearchResultDTO product,
        int quantity,
        SalesOrderProduct.OrderProductStatus status,
        BigDecimal unitPrice,
        BigDecimal total,
        Instant shippedAt,
        Instant deliveryStartedAt,
        Instant deliveredAt
) implements Serializable {
}