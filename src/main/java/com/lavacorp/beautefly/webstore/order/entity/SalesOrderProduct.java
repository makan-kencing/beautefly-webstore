package com.lavacorp.beautefly.webstore.order.entity;

import com.lavacorp.beautefly.webstore.product.entity.Product;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
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
    @EmbeddedId
    private SalesOrderProductId id = new SalesOrderProductId();

    @MapsId(SalesOrderProductId_.ORDER_ID)
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    private SalesOrder order;

    @MapsId(SalesOrderProductId_.PRODUCT_ID)
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    private Product product;

    @NotNull
    @Positive
    private int quantity;

    @NotNull
    @Positive
    private BigDecimal unitPrice;

    @NotNull
    @Positive
    private BigDecimal unitCost;

    @PastOrPresent
    private Instant shippedAt;

    @PastOrPresent
    private Instant deliveryStartedAt;

    @PastOrPresent
    private Instant deliveredAt;

    public OrderProductStatus getStatus() {
        if (deliveredAt != null)
            return OrderProductStatus.DELIVERED;

        if (deliveryStartedAt != null)
            return OrderProductStatus.OUT_FOR_DELIVERY;

        if (shippedAt != null)
            return OrderProductStatus.SHIPPED;

        return OrderProductStatus.ORDERED;
    }

    public BigDecimal getTotal() {
        return unitPrice.multiply(BigDecimal.valueOf(quantity));
    }

    public enum OrderProductStatus {
        ORDERED, SHIPPED, OUT_FOR_DELIVERY, DELIVERED
    }
}
