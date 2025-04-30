package com.lavacorp.beautefly.webstore.admin;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.mapper.AccountMapper;
import com.lavacorp.beautefly.webstore.admin.dto.DeleteAccountDTO;
import com.lavacorp.beautefly.webstore.cart.entity.Cart;
import com.lavacorp.beautefly.webstore.cart.entity.Wishlist;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.transaction.Transactional;
import org.hibernate.SessionFactory;

@Transactional
@ApplicationScoped
public class AdminAccountService {

    @PersistenceUnit
    private EntityManagerFactory emf;

    @Inject
    private AccountMapper accountMapper;

    public void register(Account account) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(account);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void deleteAccounts(DeleteAccountDTO dto) {
        var sf = emf.unwrap(SessionFactory.class);
        var statelessSession = sf.openStatelessSession();

        statelessSession.createMutationQuery("""
                        update FileUpload f
                        set f.createdBy = null
                        where f.createdBy.id in :accountId
                        """)
                .setParameter("accountId", dto.id())
                .executeUpdate();

//        for (var id : dto.id()) {
//            var cart = statelessSession.createSelectionQuery("""
//                            from Cart
//                            left join fetch CartProduct
//                            where Account.id = :accountId
//                            """, Cart.class)
//                    .setParameter("accountId", id)
//                    .getSingleResultOrNull();
//
//            if (cart != null) {
//                cart.forEach(statelessSession::delete);
//                statelessSession.delete(cart);
//            }
//
//            var wishlist = statelessSession.createSelectionQuery("""
//                            from Wishlist
//                            left join fetch WishlistProduct
//                            where Account.id = :accountId
//                            """, Wishlist.class)
//                    .setParameter("accountId", id)
//                    .getSingleResultOrNull();
//
//            if (wishlist != null) {
//                wishlist.forEach(statelessSession::delete);
//                statelessSession.delete(wishlist);
//            }
//        }

        statelessSession.createMutationQuery("""
                        delete CartProduct cp
                        where cp.cart.account.id in :accountId
                        """)
                .setParameter("accountId", dto.id())
                .executeUpdate();

        statelessSession.createMutationQuery("""
                        delete Cart c
                        where c.account.id in :accountId
                        """)
                .setParameter("accountId", dto.id())
                .executeUpdate();

        statelessSession.createMutationQuery("""
                        delete WishlistProduct wp
                        where wp.cart.account.id in :accountId
                        """)
                .setParameter("accountId", dto.id())
                .executeUpdate();

        statelessSession.createMutationQuery("""
                        delete Wishlist w
                        where w.account.id in :accountId
                        """)
                .setParameter("accountId", dto.id())
                .executeUpdate();

        statelessSession.createMutationQuery("""
                        delete SalesOrderProduct sop
                        where sop.order.account.id in :accountId
                        """)
                .setParameter("accountId", dto.id())
                .executeUpdate();

        statelessSession.createMutationQuery("""
                        delete SalesOrder so
                        where so.account.id in :accountId
                        """)
                .setParameter("accountId", dto.id())
                .executeUpdate();

        statelessSession.createMutationQuery("""
                        delete Reply r
                        where r.account.id in :accountId
                        """)
                .setParameter("accountId", dto.id())
                .executeUpdate();

        statelessSession.createMutationQuery("""
                        delete Reply r
                        where r.original.account.id in :accountId
                        """)
                .setParameter("accountId", dto.id())
                .executeUpdate();

        statelessSession.createMutationQuery("""
                        delete Rating r
                        where r.account.id in :accountId
                        """)
                .setParameter("accountId", dto.id())
                .executeUpdate();

        var session = sf.openSession();
        for (var id : dto.id()) {
            var account = session.get(Account.class, id);
            if (account != null)
                session.remove(account);
        }
    }
}
