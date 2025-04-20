package com.lavacorp.beautefly.webstore.order.entity;

import jakarta.persistence.Embeddable;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Embeddable
public class SalesOrderProductId {
    private int orderId;
    private int productId;
}
