package com.lavacorp.beautefly.webstore.rating.entity;

import com.lavacorp.beautefly.webstore.account.entity.UserAccount;
import com.lavacorp.beautefly.webstore.product.entity.Product;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PastOrPresent;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CurrentTimestamp;
import org.hibernate.validator.constraints.Range;
import org.hibernate.validator.constraints.URL;

import java.io.Serializable;
import java.time.Instant;
import java.util.Set;

@Getter
@Setter
@Entity
public class Rating implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    private UserAccount account;

    @ManyToOne
    private Product product;

    @NotNull
    @Range(min = 0, max = 5)
    private int rating;

    private String message;

    @ElementCollection
    private Set<@URL String> imageUrls;

    @CurrentTimestamp
    @PastOrPresent
    private Instant ratedOn;

    @OneToMany(mappedBy = Reply_.ORIGINAL)
    private Set<Reply> replies;
}
