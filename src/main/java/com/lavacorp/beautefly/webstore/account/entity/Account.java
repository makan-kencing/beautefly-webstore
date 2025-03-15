package com.lavacorp.beautefly.webstore.account.entity;

import com.lavacorp.beautefly.webstore.cart.entity.CartProduct;
import com.lavacorp.beautefly.webstore.cart.entity.CartProduct_;
import com.lavacorp.beautefly.webstore.order.entity.SalesOrder;
import com.lavacorp.beautefly.webstore.order.entity.SalesOrder_;
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

@Data
@Entity
public class Account implements Serializable {
    @Id
    @GeneratedValue
    private int id;

    @ElementCollection
    @NaturalId
    @Enumerated(EnumType.STRING)
    private Set<Role> roles = Set.of(Role.USER);

    @NotBlank
    private String username;

    @NotNull
    @Email
    @NaturalId
    private String email;

    @NotNull
    private String password;

    @Past
    private LocalDate dob;

    @OneToMany(mappedBy = Address_.ACCOUNT)
    private Set<Address> addresses;

    @Nullable
    @OneToOne
    private Address defaultAddress;

    @OneToMany(mappedBy = CartProduct_.ACCOUNT)
    private Set<CartProduct> cart;

    @OneToMany(mappedBy = WishlistProduct_.ACCOUNT)
    private Set<WishlistProduct> wishlist;

    @OneToMany(mappedBy = SalesOrder_.ACCOUNT)
    private Set<SalesOrder> orders;

    public int getAge() {
        return (int) (Duration.between(LocalDate.now(), dob).toDays() / 365);
    }

    public enum Role {
        USER, ADMIN, STAFF
    }
}
