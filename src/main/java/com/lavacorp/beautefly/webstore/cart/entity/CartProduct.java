package com.lavacorp.beautefly.webstore.cart.entity;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.product.entity.Product;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PastOrPresent;
import jakarta.validation.constraints.Positive;
import lombok.Data;
import org.hibernate.annotations.CurrentTimestamp;

import java.io.Serializable;
import java.time.Instant;

@Data
@Entity
public class CartProduct implements Serializable {
    @Id
    @ManyToOne
    private Account account;

    @Id
    @ManyToOne
    private Product product;

    @NotNull
    @Positive
    private int quantity;

    @CurrentTimestamp
    @PastOrPresent
    private Instant addedOn;
}
