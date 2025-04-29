package com.lavacorp.beautefly.webstore.order.dto;

import com.lavacorp.beautefly.webstore.account.dto.AddressDTO;
import com.lavacorp.beautefly.webstore.order.entity.SalesOrder;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.order.entity.SalesOrder}
 */
public record OrderDetailsDTO(
        int id,
        AddressDTO shippingAddress,
        SalesOrder.OrderStatus status,
        String paymentMethod,
        Instant orderedAt,
        BigDecimal taxAmount,
        BigDecimal shippingAmount,
        BigDecimal discountAmount,
        BigDecimal grossAmount,
        BigDecimal netAmount,
        Instant completedAt,
        List<OrderItemDTO> products
) implements Serializable {
}