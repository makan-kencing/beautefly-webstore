package com.lavacorp.beautefly.webstore.guest;

import com.lavacorp.beautefly.webstore.guest.entity.Guest;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceUnit;
import jakarta.transaction.Transactional;

import java.util.Optional;

@ApplicationScoped
@Transactional
public class GuestRepositoryImpl implements GuestRepository {
    @PersistenceUnit
    private EntityManager em;

    @Override
    public <S extends Guest> S insert(S entity) {
        em.persist(entity);

        return entity;
    }

    @Override
    public <S extends Guest> S update(S entity) {
        em.merge(entity);

        return entity;
    }

    @Override
    public <S extends Guest> S save(S entity) {
        if (!em.contains(entity))
            return insert(entity);
        return update(entity);
    }

    @Override
    public Optional<Guest> findById(String id) {
        return Optional.of(
                em.createQuery("SELECT g FROM Guest g WHERE g.id = :id", Guest.class)
                .setParameter("id", id)
                .getSingleResult()
        );
    }

    @Override
    public void delete(Guest entity) {
        em.remove(entity);
    }

    @Override
    public void deleteById(String id) {
        em.createQuery("DELETE FROM Guest g WHERE g.id = :id", Guest.class)
                .setParameter("id", id)
                .executeUpdate();
    }
}
