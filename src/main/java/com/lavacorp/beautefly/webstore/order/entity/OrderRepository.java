package com.lavacorp.beautefly.webstore.order.entity;

import jakarta.annotation.Nullable;

import java.util.List;

public interface OrderRepository {
    @Nullable
    SalesOrder findById(int id);

    List<SalesOrder> findPaged(int offset, int limit);

    long count();
}
