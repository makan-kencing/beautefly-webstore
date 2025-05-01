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
            GROUP BY TO_CHAR(o.orderedAt, 'YYYY-MM-DD')
            ORDER BY TO_CHAR(o.orderedAt, 'YYYY-MM-DD')
        """, BigDecimal.class)
                .setParameter("startDate", startDate)
                .getResultList();
    }

    @Override
    public List<String> getDailyLabels() {
        Instant startDate = LocalDate.now().minusDays(30).atStartOfDay(ZoneId.systemDefault()).toInstant();
        return em.createQuery("""
            SELECT TO_CHAR(o.orderedAt, 'YYYY-MM-DD')
            FROM SalesOrderProduct p
            JOIN p.order o
            WHERE o.orderedAt >= :startDate
            GROUP BY TO_CHAR(o.orderedAt, 'YYYY-MM-DD')
            ORDER BY TO_CHAR(o.orderedAt, 'YYYY-MM-DD')
        """, String.class)
                .setParameter("startDate", startDate)
                .getResultList();
    }

    @Override
    public List<Integer> getDailyOrderCount() {
        Instant startDate = LocalDate.now().minusDays(30).atStartOfDay(ZoneId.systemDefault()).toInstant();
        return em.createQuery("""
        SELECT COUNT(o)
        FROM SalesOrderProduct p
        JOIN p.order o
        WHERE o.orderedAt >= :startDate
        GROUP BY TO_CHAR(o.orderedAt, 'YYYY-MM-DD')
        ORDER BY TO_CHAR(o.orderedAt, 'YYYY-MM-DD')
    """, Long.class)
                .setParameter("startDate", startDate)
                .getResultList()
                .stream()
                .map(Long::intValue) // 把Long轉成Integer
                .toList();
    }


    @Override
    public List<BigDecimal> getMonthlySales() {
        Instant startDate = LocalDate.now().minusMonths(12).atStartOfDay(ZoneId.systemDefault()).toInstant();
        return em.createQuery("""
            SELECT SUM(p.unitPrice * p.quantity)
            FROM SalesOrderProduct p
            JOIN p.order o
            WHERE o.orderedAt >= :startDate
            GROUP BY TO_CHAR(o.orderedAt, 'YYYY-MM')
            ORDER BY TO_CHAR(o.orderedAt, 'YYYY-MM')
        """, BigDecimal.class)
                .setParameter("startDate", startDate)
                .getResultList();
    }

    @Override
    public List<String> getMonthlyLabels() {
        Instant startDate = LocalDate.now().minusMonths(12).atStartOfDay(ZoneId.systemDefault()).toInstant();
        return em.createQuery("""
            SELECT TO_CHAR(o.orderedAt, 'YYYY-MM')
            FROM SalesOrderProduct p
            JOIN p.order o
            WHERE o.orderedAt >= :startDate
            GROUP BY TO_CHAR(o.orderedAt, 'YYYY-MM')
            ORDER BY TO_CHAR(o.orderedAt, 'YYYY-MM')
        """, String.class)
                .setParameter("startDate", startDate)
                .getResultList();
    }

    @Override
    public List<Integer> getMonthlyOrderCount() {
        Instant startDate = LocalDate.now().minusMonths(12).atStartOfDay(ZoneId.systemDefault()).toInstant();
        return em.createQuery("""
        SELECT COUNT(o)
        FROM SalesOrderProduct p
        JOIN p.order o
        WHERE o.orderedAt >= :startDate
        GROUP BY TO_CHAR(o.orderedAt, 'YYYY-MM')
        ORDER BY TO_CHAR(o.orderedAt, 'YYYY-MM')
    """, Long.class)
                .setParameter("startDate", startDate)
                .getResultList()
                .stream()
                .map(Long::intValue)
                .toList();
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

    @Override
    public SalesOrderProduct findOrderProductById(int id) {
        return em.createQuery("""
        SELECT p FROM SalesOrderProduct p
        WHERE p.id = :id
    """, SalesOrderProduct.class)
                .setParameter("id", id)
                .getResultStream()
                .findFirst()
                .orElse(null);
    }

    @Override
    public void updateOrderProduct(SalesOrderProduct product) {
        em.merge(product);
    }
}
