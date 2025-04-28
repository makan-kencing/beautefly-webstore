package com.lavacorp.beautefly.webstore.order.entity;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;

@ApplicationScoped
@Transactional
public class OrderRepositoryImpl implements OrderRepository {

    @PersistenceContext
    private EntityManager em;

    @Override
    public SalesOrder findById(int id) {
        return em.find(SalesOrder.class, id);
    }

    @Override
    public List<BigDecimal> getDailySales() {
        Instant startDate = LocalDate.now().minusDays(30).atStartOfDay(ZoneId.systemDefault()).toInstant();
        return em.createQuery("""
        SELECT SUM(p.unitPrice * p.quantity)
        FROM SalesOrderProduct p
        JOIN p.order o
        WHERE o.orderedAt >= :startDate
        GROUP BY FUNCTION('DATE', o.orderedAt)
        ORDER BY FUNCTION('DATE', o.orderedAt)
    """, BigDecimal.class)
                .setParameter("startDate", startDate)
                .getResultList();
    }

    @Override
    public List<String> getDailyLabels() {
        Instant startDate = LocalDate.now().minusDays(30).atStartOfDay(ZoneId.systemDefault()).toInstant();
        return em.createQuery("""
        SELECT FUNCTION('DATE', o.orderedAt)
        FROM SalesOrderProduct p
        JOIN p.order o
        WHERE o.orderedAt >= :startDate
        GROUP BY FUNCTION('DATE', o.orderedAt)
        ORDER BY FUNCTION('DATE', o.orderedAt)
    """, String.class)
                .setParameter("startDate", startDate)
                .getResultList();
    }

    @Override
    public List<Integer> getDailyOrderCount() {
        Instant startDate = LocalDate.now().minusDays(7).atStartOfDay(ZoneId.systemDefault()).toInstant();
        return em.createQuery("""
            SELECT COUNT(DISTINCT o.id)
            FROM SalesOrderProduct p
            JOIN p.order o
            WHERE o.orderedAt >= :startDate
            GROUP BY FUNCTION('DATE', o.orderedAt)
            ORDER BY FUNCTION('DATE', o.orderedAt)
        """, Integer.class)
                .setParameter("startDate", startDate)
                .getResultList();
    }
    
    @Override
    public List<BigDecimal> getMonthlySales() {
        Instant startDate = LocalDate.now().minusMonths(12).atStartOfDay(ZoneId.systemDefault()).toInstant();
        return em.createQuery("""
        SELECT SUM(p.unitPrice * p.quantity)
        FROM SalesOrderProduct p
        JOIN p.order o
        WHERE o.orderedAt >= :startDate
        GROUP BY EXTRACT(YEAR FROM o.orderedAt), EXTRACT(MONTH FROM o.orderedAt)
        ORDER BY EXTRACT(YEAR FROM o.orderedAt), EXTRACT(MONTH FROM o.orderedAt)
    """, BigDecimal.class)
                .setParameter("startDate", startDate)
                .getResultList();
    }

    @Override
    public List<String> getMonthlyLabels() {
        Instant startDate = LocalDate.now().minusMonths(12).atStartOfDay(ZoneId.systemDefault()).toInstant();
        return em.createQuery("""
        SELECT CONCAT(EXTRACT(YEAR FROM o.orderedAt), '-', LPAD(CAST(EXTRACT(MONTH FROM o.orderedAt) AS text), 2, '0'))
        FROM SalesOrderProduct p
        JOIN p.order o
        WHERE o.orderedAt >= :startDate
        GROUP BY EXTRACT(YEAR FROM o.orderedAt), EXTRACT(MONTH FROM o.orderedAt)
        ORDER BY EXTRACT(YEAR FROM o.orderedAt), EXTRACT(MONTH FROM o.orderedAt)
    """, String.class)
                .setParameter("startDate", startDate)
                .getResultList();
    }

    @Override
    public List<Integer> getMonthlyOrderCount() {
        Instant startDate = LocalDate.now().minusMonths(6).atStartOfDay(ZoneId.systemDefault()).toInstant();
        return em.createQuery("""
            SELECT COUNT(DISTINCT o.id)
            FROM SalesOrderProduct p
            JOIN p.order o
            WHERE o.orderedAt >= :startDate
            GROUP BY FUNCTION('MONTH', o.orderedAt)
            ORDER BY FUNCTION('MONTH', o.orderedAt)
        """, Integer.class)
                .setParameter("startDate", startDate)
                .getResultList();
    }

    @Override
    public List<BigDecimal> getTotalSales() {
        return em.createQuery("""
            SELECT SUM(p.unitPrice * p.quantity)
            FROM SalesOrderProduct p
        """, BigDecimal.class)
                .getResultList();
    }

    @Override
    public List<String> getTotalLabels() {
        return List.of("Total Sales");
    }

    @Override
    public List<Integer> getTotalOrderCount() {
        return List.of(em.createQuery("""
            SELECT COUNT(DISTINCT o.id)
            FROM SalesOrderProduct p
            JOIN p.order o
        """, Long.class)
                .getSingleResult()
                .intValue());
    }

    @Override
    public BigDecimal sumTotalSales() {
        return em.createQuery("""
        SELECT COALESCE(SUM(p.unitPrice * p.quantity), 0)
        FROM SalesOrderProduct p
    """, BigDecimal.class).getSingleResult();
    }

    @Override
    public BigDecimal sumTodaySales() {
        Instant today = LocalDate.now().atStartOfDay(ZoneId.systemDefault()).toInstant();
        return em.createQuery("""
        SELECT COALESCE(SUM(p.unitPrice * p.quantity), 0)
        FROM SalesOrderProduct p
        JOIN p.order o
        WHERE o.orderedAt >= :today
    """, BigDecimal.class)
                .setParameter("today", today)
                .getSingleResult();
    }

    @Override
    public BigDecimal sumMonthlySales() {
        Instant startOfMonth = LocalDate.now().withDayOfMonth(1).atStartOfDay(ZoneId.systemDefault()).toInstant();
        return em.createQuery("""
        SELECT COALESCE(SUM(p.unitPrice * p.quantity), 0)
        FROM SalesOrderProduct p
        JOIN p.order o
        WHERE o.orderedAt >= :startOfMonth
    """, BigDecimal.class)
                .setParameter("startOfMonth", startOfMonth)
                .getSingleResult();
    }
}
