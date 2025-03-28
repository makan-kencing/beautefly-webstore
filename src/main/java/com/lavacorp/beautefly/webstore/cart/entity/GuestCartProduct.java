package com.lavacorp.beautefly.webstore.cart.entity;

import com.lavacorp.beautefly.webstore.guest.entity.Guest;
import com.lavacorp.beautefly.webstore.product.entity.Product;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PastOrPresent;
import jakarta.validation.constraints.Positive;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CurrentTimestamp;

import java.io.Serializable;
import java.time.Instant;

@Getter
@Setter
@Entity
public class GuestCartProduct implements Serializable {
    @Id
    @ManyToOne
    private Guest guest;

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
