package com.lavacorp.beautefly.webstore.account;

import com.lavacorp.beautefly.webstore.account.entity.Account;
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
    public int register(Account account) {
        em.persist(account);
        return account.getId();
    }

    @Override
    public @Nullable Account findUserAccount(int id) {
        try {
            return em.find(Account.class, id);
        } catch (NoResultException ignored) {
            return null;
        }
    }

    @Override
    public List<Account> findByUsername(String username) {
        return em.createNamedQuery("Account.findByUsername", Account.class)
                .setParameter("username", username)
                .getResultList();
    }

    @Override
    public Page<Account> findByUsernameLike(String username, PageRequest page, List<Order<? super Account>> orderBy) {
        SelectionQuery<Account> query = em.unwrap(Session.class)
                .createNamedSelectionQuery("Account.findByUsernameLike", Account.class)
                .setParameter("username", username);

        List<Account> accounts = query
                .setOrder(orderBy)
                .setFirstResult((int) (page.page() - 1) * page.size())
                .setMaxResults(page.size())
                .getResultList();
        long total = query.getResultCount();

        return new PageRecord<>(page, accounts, total);
    }

    @Override
    public @Nullable Account findByEmail(String email) {
        try {
            return em.createNamedQuery("Account.findByEmail", Account.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException ignored) {
            return null;
        }
    }

    @Override
    public void update(Account account) {
        em.merge(account);
    }

    @Override
    public void delete(Account account) {
        em.remove(account);
    }

    @Override
    public void deleteById(int id) {
        em.remove(em.getReference(Account.class, id));
    }
}
