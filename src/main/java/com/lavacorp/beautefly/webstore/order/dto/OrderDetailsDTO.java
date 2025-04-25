package com.lavacorp.beautefly.webstore.order.dto;

import com.lavacorp.beautefly.webstore.account.dto.AddressDTO;
import com.lavacorp.beautefly.webstore.admin.dto.UserAccountSummaryDTO;
import com.lavacorp.beautefly.webstore.order.entity.SalesOrder;
import com.lavacorp.beautefly.webstore.security.dto.AccountContextDTO;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;
import java.util.Set;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.order.entity.SalesOrder}
 */
public record OrderDetailsDTO(
        int id,
        AddressDTO shippingAddress,
        AccountContextDTO account,
        SalesOrder.OrderStatus status,
        SalesOrder.PaymentMethod paymentMethod,
        Instant orderedAt,
        BigDecimal taxAmount,
        BigDecimal shippingAmount,
        BigDecimal discountAmount,
        BigDecimal grossAmount,
        BigDecimal netAmount,
        List<OrderItemDTO> products
) implements Serializable {
}