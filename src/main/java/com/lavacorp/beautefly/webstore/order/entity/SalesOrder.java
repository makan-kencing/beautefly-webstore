package com.lavacorp.beautefly.webstore.order.entity;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.entity.Address;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PastOrPresent;
import jakarta.validation.constraints.PositiveOrZero;
import lombok.Data;
import org.hibernate.annotations.CurrentTimestamp;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.Set;

@Data
@Entity
public class SalesOrder implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    private Account account;

    @ManyToOne
    private Address shippingAddress;

    @Enumerated(EnumType.STRING)
    private Status status = Status.ARRIVING;

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

    @OneToMany(mappedBy = SalesOrderProduct_.ORDER)
    private Set<SalesOrderProduct> orderedProducts;

    public BigDecimal getGrossAmount() {
        return orderedProducts.stream()
                .map(SalesOrderProduct::getUnitPrice)
                .reduce(BigDecimal::add)
                .orElse(BigDecimal.valueOf(0));
    }

    public BigDecimal getNetAmount() {
        return getGrossAmount().subtract(taxAmount).subtract(shippingAmount).add(discountAmount);
    }

    public enum Status {
        ARRIVING, COMPLETED, CANCELLED
    }

    public enum PaymentMethod {
        DEBIT, CREDIT, CASH_ON_DELIVERY, BANK_TRANSFER
    }
}
