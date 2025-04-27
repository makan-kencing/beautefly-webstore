package com.lavacorp.beautefly.webstore.order.entity;

import com.lavacorp.beautefly.webstore.common.entity.ProductItemId;
import jakarta.persistence.Embeddable;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Embeddable
public class SalesOrderProductId extends ProductItemId {
    private int orderId;
    private int productId;
}
