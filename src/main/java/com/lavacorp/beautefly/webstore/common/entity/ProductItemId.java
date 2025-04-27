package com.lavacorp.beautefly.webstore.common.entity;

import jakarta.persistence.Embeddable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.Objects;

@Getter
@Setter
@Embeddable
public class ProductItemId implements Serializable {
    private int productId;

    @Override
    public final boolean equals(Object o) {
        if (this == o)
            return true;

        if (o == null)
            return false;

        if (o instanceof Integer id)
            return productId == id;

        if (o instanceof ProductItemId id)
            return productId == id.getProductId();

        return false;
    }

    @Override
    public final int hashCode() {
        return Objects.hash(productId);
    }
}
