package com.lavacorp.beautefly.webstore.order.entity;

import com.lavacorp.beautefly.webstore.product.entity.Product;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.validation.constraints.PastOrPresent;
import jakarta.validation.constraints.Positive;
import lombok.Data;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.Instant;

@Data
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

    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    private Status status = Status.ORDERED;

    @Positive
    private BigDecimal unitPrice;

    @Positive
    private BigDecimal unitCost;

    @PastOrPresent
    private Instant deliveredAt;

    public enum Status {
        ORDERED, SHIPPED, OUT_FOR_DELIVERY, DELIVERED
    }
}
