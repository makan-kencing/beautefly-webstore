package com.lavacorp.beautefly.webstore.wishlist.entity;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.product.entity.Product;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.validation.constraints.PastOrPresent;
import lombok.Data;
import org.hibernate.annotations.CurrentTimestamp;

import java.io.Serializable;
import java.time.Instant;

@Data
@Entity
public class WishlistProduct implements Serializable {
    @Id
    @ManyToOne
    private Account account;

    @Id
    @ManyToOne
    private Product product;

    @CurrentTimestamp
    @PastOrPresent
    private Instant addedOn;
}
