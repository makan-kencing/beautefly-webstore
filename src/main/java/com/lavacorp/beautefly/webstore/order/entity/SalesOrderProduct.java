package com.lavacorp.beautefly.webstore.order.entity;

import com.lavacorp.beautefly.webstore.product.entity.Product;
import jakarta.persistence.*;
import jakarta.validation.constraints.PastOrPresent;
import jakarta.validation.constraints.Positive;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.Instant;

@Getter
@Setter
@Entity
public class SalesOrderProduct implements Serializable {
    @Id
    @ManyToOne
    private SalesOrder order;

    @Id
    @ManyToOne
    private Product product;

    @Positive
    private int quantity;

    @Enumerated(EnumType.STRING)
    private OrderProductStatus status = OrderProductStatus.ORDERED;

    @Positive
    private BigDecimal unitPrice;

    @Positive
    private BigDecimal unitCost;

    @PastOrPresent
    private Instant deliveredAt;

    public enum OrderProductStatus {
        ORDERED, SHIPPED, OUT_FOR_DELIVERY, DELIVERED
    }
}
