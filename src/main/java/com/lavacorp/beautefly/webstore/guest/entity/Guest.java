package com.lavacorp.beautefly.webstore.guest.entity;

import com.lavacorp.beautefly.webstore.cart.entity.GuestCartProduct;
import com.lavacorp.beautefly.webstore.cart.entity.GuestCartProduct_;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.Set;

import static jakarta.persistence.FetchType.LAZY;

@Getter
@Setter
@Entity
public class Guest implements Serializable {
    @Id
    private String sessionId;

    @OneToMany(mappedBy = GuestCartProduct_.GUEST, fetch = LAZY)
    private transient Set<GuestCartProduct> cart;
}
