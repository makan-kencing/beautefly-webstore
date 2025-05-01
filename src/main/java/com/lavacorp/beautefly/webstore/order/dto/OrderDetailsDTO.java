package com.lavacorp.beautefly.webstore.order.dto;

import com.lavacorp.beautefly.webstore.account.dto.AddressDTO;
import com.lavacorp.beautefly.webstore.order.entity.SalesOrder;
import com.lavacorp.beautefly.webstore.order.entity.SalesOrderProduct;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;
import java.util.Objects;

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
    public SalesOrderProduct.OrderProductStatus orderProductStatus() {
        return products.stream()
                .map(OrderItemDTO::status)
                .sorted()
                .findFirst()
                .orElseThrow();
    }

    public boolean isShipped() {
        return orderProductStatus().compareTo(SalesOrderProduct.OrderProductStatus.SHIPPED) >= 0;
    }

    public boolean isDelivering() {
        return orderProductStatus().compareTo(SalesOrderProduct.OrderProductStatus.OUT_FOR_DELIVERY) >= 0;
    }

    public boolean isDelivered() {
        return orderProductStatus().compareTo(SalesOrderProduct.OrderProductStatus.DELIVERED) >= 0;
    }

    public Instant shippedAt() {
        return products.stream()
                .map(OrderItemDTO::shippedAt)
                .filter(Objects::nonNull)
                .sorted()
                .findFirst()
                .orElse(null);
    }
    public Instant deliveryStartedAt() {
        return products.stream()
                .map(OrderItemDTO::deliveryStartedAt)
                .filter(Objects::nonNull)
                .sorted()
                .findFirst()
                .orElse(null);
    }
    public Instant deliveredAt() {
        return products.stream()
                .map(OrderItemDTO::deliveredAt)
                .filter(Objects::nonNull)
                .sorted()
                .findFirst()
                .orElse(null);
    }
}