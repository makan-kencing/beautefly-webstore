package com.lavacorp.beautefly.webstore.rating.entity;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.product.entity.Product;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PastOrPresent;
import lombok.Data;
import org.hibernate.annotations.CurrentTimestamp;
import org.hibernate.validator.constraints.Range;

import java.io.Serializable;
import java.time.Instant;
import java.util.Set;

@Data
@Entity
public class Rating implements Serializable {
    @Id
    @GeneratedValue
    private int id;

    @ManyToOne
    private Account account;

    @ManyToOne
    private Product product;

    @NotNull
    @Range(min = 0, max = 5)
    private int rating;

    private String message;

    @CurrentTimestamp
    @PastOrPresent
    private Instant ratedOn;

    @OneToMany(mappedBy = Reply_.ORIGINAL)
    private Set<Reply> replies;
}
