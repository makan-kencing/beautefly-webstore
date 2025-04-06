package com.lavacorp.beautefly.webstore.cart.entity;

import com.lavacorp.beautefly.webstore.account.entity.Account;
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
import org.hibernate.proxy.HibernateProxy;

import java.io.Serializable;
import java.time.Instant;
import java.util.Objects;

@Getter
@Setter
@Entity
public class CartProduct implements Serializable {
    @Id
    @ManyToOne
    private Account account;

    @Id
    @ManyToOne
    private Product product;

    @NotNull
    @Positive
    private int quantity;

    @CurrentTimestamp
    @PastOrPresent
    private Instant addedOn;

    @Override
    public final boolean equals(Object o) {
        if (this == o) return true;
        if (o == null) return false;
        Class<?> oEffectiveClass = o instanceof HibernateProxy ? ((HibernateProxy) o).getHibernateLazyInitializer().getPersistentClass() : o.getClass();
        Class<?> thisEffectiveClass = this instanceof HibernateProxy ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass() : this.getClass();
        if (thisEffectiveClass != oEffectiveClass) return false;
        CartProduct that = (CartProduct) o;
        return getProduct() != null && Objects.equals(getProduct(), that.getProduct());
    }

    @Override
    public final int hashCode() {
        return this instanceof HibernateProxy ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass().hashCode() : getClass().hashCode();
    }
}
