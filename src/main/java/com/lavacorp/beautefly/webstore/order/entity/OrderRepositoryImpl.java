package com.lavacorp.beautefly.webstore.order.entity;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.util.List;

@ApplicationScoped
@Transactional
public class OrderRepositoryImpl implements OrderRepository {

    @PersistenceContext
    private EntityManager em;

    @Override
    public SalesOrder findById(int id) {
        try {
            return em.find(SalesOrder.class, id);
        } catch (NoResultException ignored) {
            return null;
        }
    }

    @Override
    public List<SalesOrder> findPaged(int offset, int limit) {
        return em.createQuery("SELECT o FROM SalesOrder o ORDER BY o.orderedAt DESC", SalesOrder.class)
                .setFirstResult(offset)
                .setMaxResults(limit)
                .getResultList();
    }

    @Override
    public long count() {
        return em.createQuery("SELECT COUNT(o) FROM SalesOrder o", Long.class)
                .getSingleResult();
    }

    @Override
    public void updateStatus(int orderId, SalesOrder.OrderStatus newStatus) {
        SalesOrder order = em.find(SalesOrder.class, orderId);
        if (order != null) {
            order.setStatus(newStatus);
            em.merge(order);
        }
    }
}
