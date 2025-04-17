package com.lavacorp.beautefly.webstore.account;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.entity.GuestAccount;
import com.lavacorp.beautefly.webstore.account.entity.UserAccount;
import jakarta.annotation.Nullable;
import jakarta.data.page.Page;
import jakarta.data.page.PageRequest;
import jakarta.data.page.impl.PageRecord;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import org.hibernate.Session;
import org.hibernate.query.Order;
import org.hibernate.query.SelectionQuery;

import java.util.List;

@ApplicationScoped
@Transactional
public class AccountRepositoryImpl implements AccountRepository {
    @PersistenceContext
    private EntityManager em;

    @Override
    public UserAccount register(UserAccount account) {
        em.persist(account);
        return account;
    }

    @Override
    public GuestAccount createGuest(GuestAccount account) {
        em.persist(account);
        return account;
    }

    @Override
    public @Nullable UserAccount findUserAccount(int id) {
        try {
            return em.find(UserAccount.class, id);
        } catch (NoResultException ignored) {
            return null;
        }
    }

    @Override
    public List<UserAccount> findByUsername(String username) {
        return em.createNamedQuery("UserAccount.findByUsername", UserAccount.class)
                .setParameter("username", username)
                .getResultList();
    }

    @Override
    public Page<UserAccount> findByUsernameLike(String username, PageRequest page, List<Order<? super UserAccount>> orderBy) {
        SelectionQuery<UserAccount> query = em.unwrap(Session.class)
                .createNamedSelectionQuery("UserAccount.findByUsernameLike", UserAccount.class)
                .setParameter("username", username);

        List<UserAccount> accounts = query
                .setOrder(orderBy)
                .setFirstResult((int) (page.page() - 1) * page.size())
                .setMaxResults(page.size())
                .getResultList();
        long total = query.getResultCount();

        return new PageRecord<>(page, accounts, total);
    }

    @Override
    public @Nullable UserAccount findByEmail(String email) {
        try {
            return em.createNamedQuery("UserAccount.findByEmail", UserAccount.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException ignored) {
            return null;
        }
    }

    @Override
    public @Nullable GuestAccount findBySessionId(String sessionId) {
        try {
            return em.createNamedQuery("GuestAccount.findBySessionId", GuestAccount.class)
                    .setParameter("sessionId", sessionId)
                    .getSingleResult();
        } catch (NoResultException ignored) {
            return null;
        }
    }

    @Override
    public void update(UserAccount account) {
        em.merge(account);
    }

    @Override
    public void delete(UserAccount account) {
        em.remove(account);
    }

    @Override
    public void deleteById(int id) {
        em.remove(em.getReference(Account.class, id));
    }
}
