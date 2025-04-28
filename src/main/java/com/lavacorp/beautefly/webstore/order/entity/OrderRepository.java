package com.lavacorp.beautefly.webstore.order.entity;

import jakarta.annotation.Nullable;
import java.math.BigDecimal;
import java.util.List;

public interface OrderRepository {
    @Nullable
    SalesOrder findById(int id);

    List<BigDecimal> getDailySales();
    List<String> getDailyLabels();
    List<Integer> getDailyOrderCount();

    List<BigDecimal> getMonthlySales();
    List<String> getMonthlyLabels();
    List<Integer> getMonthlyOrderCount();

    List<BigDecimal> getTotalSales();
    List<String> getTotalLabels();
    List<Integer> getTotalOrderCount();

    BigDecimal sumTotalSales();
    BigDecimal sumTodaySales();
    BigDecimal sumMonthlySales();
}
