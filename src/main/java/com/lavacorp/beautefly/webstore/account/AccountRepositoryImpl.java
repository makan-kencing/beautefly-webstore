package com.lavacorp.beautefly.webstore.account;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import jakarta.data.page.Page;
import jakarta.data.page.PageRequest;
import jakarta.data.page.impl.PageRecord;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
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
    public Account register(Account account) {
        em.persist(account);
        return account;
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
    public Account findByEmail(String email) {
        return em.createNamedQuery("Account.findByEmail", Account.class)
                .setParameter("email", email)
                .getSingleResult();
    }

    @Override
    public void update(Account account) {
        em.merge(account);
    }

    @Override
    public void delete(Account account) {
        em.remove(account);
    }
}
