package com.lavacorp.beautefly.webstore.admin.account;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.mapper.AccountMapper;
import com.lavacorp.beautefly.webstore.admin.account.dto.DeleteAccountDTO;
import com.lavacorp.beautefly.webstore.security.dto.AccountContextDTO;
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

    @SuppressWarnings("JpaQlInspection")
    public void deleteAccounts(AccountContextDTO user, DeleteAccountDTO dto) {
        var sf = emf.unwrap(SessionFactory.class);
        var statelessSession = sf.openStatelessSession();
        var session = sf.openSession();

        var userAccount = session.get(Account.class, user.id());
        var userHighestRole = userAccount.getCredential().getRoles()
                .stream()
                .max(Enum::compareTo)
                .orElseThrow();
        dto = new DeleteAccountDTO(
                dto.id().stream()
                        .map(id -> session.get(Account.class, id))
                        .filter(account -> {
                            var accountHighestRole = account.getCredential().getRoles()
                                    .stream()
                                    .max(Enum::compareTo)
                                    .orElseThrow();

                            return userHighestRole.compareTo(accountHighestRole) > 0;
                        }).map(Account::getId)
                        .toList()
        );

        statelessSession.createMutationQuery("""
                        update FileUpload f
                        set f.createdBy = null
                        where f.createdBy.id in :accountId
                        """)
                .setParameter("accountId", dto.id())
                .executeUpdate();

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

        for (var id : dto.id()) {
            userAccount = session.get(Account.class, id);
            if (userAccount != null)
                session.remove(userAccount);
        }
    }
}
