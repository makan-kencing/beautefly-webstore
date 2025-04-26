package com.lavacorp.beautefly.webstore.order.dto;

import com.lavacorp.beautefly.webstore.order.entity.SalesOrder;
import com.lavacorp.beautefly.webstore.security.dto.AccountContextDTO;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.order.entity.SalesOrder}
 */
public record OrderListingDTO(
        int id,
        AccountContextDTO account,
        SalesOrder.OrderStatus status,
        SalesOrder.PaymentMethod paymentMethod,
        Instant orderedAt,
        BigDecimal taxAmount,
        BigDecimal shippingAmount,
        BigDecimal discountAmount,
        BigDecimal grossAmount,
        BigDecimal netAmount,
        Instant completedAt,
        List<OrderListingItemDTO> products
) {
}
