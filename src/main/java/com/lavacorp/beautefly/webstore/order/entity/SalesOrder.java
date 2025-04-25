package com.lavacorp.beautefly.webstore.order.entity;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.entity.Address;
import jakarta.annotation.Nullable;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PastOrPresent;
import jakarta.validation.constraints.PositiveOrZero;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CurrentTimestamp;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

@Getter
@Setter
@Entity
public class SalesOrder implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    private Account account;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    private Address shippingAddress;

    @Enumerated(EnumType.STRING)
    @NotNull
    private PaymentMethod paymentMethod;

    @CurrentTimestamp
    @PastOrPresent
    private Instant orderedAt;

    @PositiveOrZero
    private BigDecimal taxAmount;

    @PositiveOrZero
    private BigDecimal shippingAmount;

    @PositiveOrZero
    private BigDecimal discountAmount;

    @OneToMany(mappedBy = SalesOrderProduct_.ORDER, fetch = FetchType.EAGER)
    private Set<SalesOrderProduct> products = new HashSet<>();

    public BigDecimal getGrossAmount() {
        return products.stream()
                .map(SalesOrderProduct::getTotal)
                .reduce(BigDecimal::add)
                .orElse(BigDecimal.valueOf(0));
    }

    public OrderStatus getStatus() {
        return getCompletedAt() != null
                ? OrderStatus.COMPLETED
                : OrderStatus.ARRIVING;
    }
    
    public @Nullable Instant getCompletedAt() {
        return products.stream()
                .map(SalesOrderProduct::getDeliveredAt)
                .filter(Objects::nonNull)
                .sorted()
                .reduce((first, second) -> second)
                .orElse(null);
    }

    public BigDecimal getNetAmount() {
        return getGrossAmount()
                .add(taxAmount)
                .add(shippingAmount)
                .subtract(discountAmount);
    }

    public enum OrderStatus {
        ARRIVING, COMPLETED
    }

    public enum PaymentMethod {
        DEBIT, CREDIT, BANK_TRANSFER
    }
}
