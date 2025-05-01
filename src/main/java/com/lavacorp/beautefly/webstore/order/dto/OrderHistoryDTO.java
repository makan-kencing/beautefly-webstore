package com.lavacorp.beautefly.webstore.order.dto;

import com.lavacorp.beautefly.webstore.account.dto.AddressDTO;
import com.lavacorp.beautefly.webstore.order.entity.SalesOrder;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.order.entity.SalesOrder}
 */
public record OrderHistoryDTO(
        int id,
        AddressDTO shippingAddress,
        Instant orderedAt,
        SalesOrder.OrderStatus status,
        BigDecimal netAmount,
        List<OrderHistoryItemDTO> items
) {
}
