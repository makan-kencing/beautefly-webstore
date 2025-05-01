package com.lavacorp.beautefly.webstore.order.dto;

import com.lavacorp.beautefly.webstore.order.entity.SalesOrderProduct;

import java.math.BigDecimal;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.order.entity.SalesOrderProduct}
 */
public record OrderHistoryItemDTO(
         OrderHistoryProductDTO product,
         int quantity,
         SalesOrderProduct.OrderProductStatus status,
         BigDecimal unitPrice,
         BigDecimal total
) {
}
