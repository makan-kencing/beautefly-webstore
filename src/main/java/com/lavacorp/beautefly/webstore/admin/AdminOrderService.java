package com.lavacorp.beautefly.webstore.admin;

import com.lavacorp.beautefly.webstore.order.dto.OrderListingDTO;
import com.lavacorp.beautefly.webstore.order.entity.SalesOrder;
import com.lavacorp.beautefly.webstore.order.mapper.OrderMapper;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.transaction.Transactional;
import org.hibernate.SessionFactory;

import java.util.List;

@Transactional
@ApplicationScoped
public class AdminOrderService {
    @PersistenceUnit
    private EntityManagerFactory emf;

    @Inject
    private OrderMapper orderMapper;

    public List<OrderListingDTO> getOrders() {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        return session.createSelectionQuery("""
                from SalesOrder so
                    join fetch so.products
                    join fetch so.account
                    left join fetch so.account.profileImage
            """, SalesOrder.class)
                .getResultStream()
                .map(orderMapper::toOrderListingDTO)
                .toList();
    }
}
