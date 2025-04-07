package com.lavacorp.beautefly.webstore.wishlist.entity;

import jakarta.persistence.Embeddable;
import jakarta.persistence.OneToMany;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import static jakarta.persistence.FetchType.LAZY;

@Getter
@Setter
@Embeddable
public class Wishlist implements Serializable {
    @OneToMany(mappedBy = WishlistProduct_.ACCOUNT, fetch = LAZY)
    private Set<WishlistProduct> products = new HashSet<>();
}
