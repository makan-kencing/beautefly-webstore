package com.lavacorp.beautefly.webstore.account.entity;

import com.lavacorp.beautefly.webstore.cart.entity.Cart;
import com.lavacorp.beautefly.webstore.wishlist.entity.Wishlist;
import jakarta.persistence.*;
import jakarta.validation.constraints.PastOrPresent;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CurrentTimestamp;

import java.io.Serializable;
import java.time.Instant;

@Getter
@Setter
@Entity
@Inheritance(strategy = InheritanceType.JOINED)
public class Account implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Embedded
    private Cart cart;

    @Embedded
    private Wishlist wishlist;

    @CurrentTimestamp
    @PastOrPresent
    private Instant createdAt;
}
