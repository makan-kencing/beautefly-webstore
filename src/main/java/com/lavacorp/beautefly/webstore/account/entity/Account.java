package com.lavacorp.beautefly.webstore.account.entity;

import com.lavacorp.beautefly.webstore.cart.entity.CartProduct;
import com.lavacorp.beautefly.webstore.cart.entity.CartProduct_;
import com.lavacorp.beautefly.webstore.order.entity.SalesOrder;
import com.lavacorp.beautefly.webstore.order.entity.SalesOrder_;
import com.lavacorp.beautefly.webstore.security.entity.Credential;
import com.lavacorp.beautefly.webstore.security.entity.Credential_;
import com.lavacorp.beautefly.webstore.wishlist.entity.WishlistProduct;
import com.lavacorp.beautefly.webstore.wishlist.entity.WishlistProduct_;
import jakarta.annotation.Nullable;
import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Past;
import lombok.Data;
import org.hibernate.annotations.NaturalId;

import java.io.Serializable;
import java.time.Duration;
import java.time.LocalDate;
import java.util.Set;

import static jakarta.persistence.FetchType.LAZY;

@Data
@Entity
public class Account implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @NotBlank
    private String username;

    @NotNull
    @Email
    @NaturalId
    private String email;

    @OneToOne(optional = false, mappedBy = Credential_.ACCOUNT)
    private Credential credential;

    @Past
    private LocalDate dob;

    @OneToMany(mappedBy = Address_.ACCOUNT, fetch = LAZY)
    private transient Set<Address> addresses;

    @Nullable
    @OneToOne(fetch = LAZY)
    private Address defaultAddress;

    @OneToMany(mappedBy = CartProduct_.ACCOUNT, fetch = LAZY)
    private transient Set<CartProduct> cart;

    @OneToMany(mappedBy = WishlistProduct_.ACCOUNT, fetch = LAZY)
    private transient Set<WishlistProduct> wishlist;

    @OneToMany(mappedBy = SalesOrder_.ACCOUNT, fetch = LAZY)
    private transient Set<SalesOrder> orders;

    public int getAge() {
        return (int) (Duration.between(LocalDate.now(), dob).toDays() / 365);
    }
}
