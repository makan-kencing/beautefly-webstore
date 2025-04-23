package com.lavacorp.beautefly.webstore.cart.entity;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.jetbrains.annotations.NotNull;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Stream;
import java.util.stream.StreamSupport;

import static jakarta.persistence.FetchType.EAGER;
import static jakarta.persistence.FetchType.LAZY;

@Getter
@Setter
@MappedSuperclass
public class CartLike<T extends CartProductLike<?>> implements Serializable, Iterable<T> {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    protected int id;

    @OneToOne(fetch = LAZY)
    protected Account account;

    @OneToMany(mappedBy = CartProductLike_.CART, fetch = LAZY)
    protected Set<T> products = new HashSet<>();

    @Override
    public @NotNull Iterator<T> iterator() {
        return products.iterator();
    }

    public Stream<T> stream() {
        return StreamSupport.stream(this.spliterator(), false);
    }

    public void clear() {
        products.clear();
    }

    public Optional<T> getCartItem(int productId) {
        return products.stream()
                .filter(p -> p.getId().getCartId() == productId)
                .findAny();
    }
}
