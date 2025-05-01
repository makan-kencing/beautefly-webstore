package com.lavacorp.beautefly.webstore.order;

import com.lavacorp.beautefly.webstore.order.dto.OrderDetailsDTO;
import com.lavacorp.beautefly.webstore.order.dto.OrderHistoryDTO;
import com.lavacorp.beautefly.webstore.order.entity.SalesOrder;
import com.lavacorp.beautefly.webstore.order.mapper.OrderMapper;
import com.lavacorp.beautefly.webstore.security.dto.AccountContextDTO;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.transaction.Transactional;
import org.hibernate.SessionFactory;

import java.util.List;

@Transactional
@ApplicationScoped
public class OrderService {
    @PersistenceUnit
    private EntityManagerFactory emf;

    @Inject
    private OrderMapper orderMapper;

    public List<OrderHistoryDTO> getOrderHistory(AccountContextDTO user) {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        return session.createSelectionQuery("""
                        from SalesOrder so
                            join fetch so.shippingAddress
                            join fetch so.products sop
                            join fetch sop.product p
                            left join fetch p.images
                        where so.account.id = :accountId
                        """, SalesOrder.class)
                .setParameter("accountId", user.id())
                .stream()
                .map(orderMapper::toOrderHistoryDTO)
                .toList();
    }

    public OrderDetailsDTO getOrderDetails(AccountContextDTO user, int orderId) {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        return session.createSelectionQuery("""
                        from SalesOrder so
                            join fetch so.shippingAddress
                            join fetch so.products sop
                            join fetch sop.product p
                            left join fetch p.images
                        where so.account.id = :accountId
                            and so.id = :orderId
                        """, SalesOrder.class)
                .setParameter("accountId", user.id())
                .setParameter("orderId", orderId)
                .stream()
                .map(orderMapper::toOrderDetailsDTO)
                .findAny()
                .orElse(null);
    }
}
