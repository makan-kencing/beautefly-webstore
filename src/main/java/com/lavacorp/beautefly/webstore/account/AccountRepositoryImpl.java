package com.lavacorp.beautefly.webstore.account;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

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
