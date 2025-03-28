package com.lavacorp.beautefly.webstore;


import java.util.Optional;

public interface BaseRepository<T, K> {
    <S extends T> S insert(S entity);

    <S extends T> S update(S entity);

    <S extends T> S save(S entity);

    Optional<T> findById(K id);

    void delete(T entity);

    void deleteById(K id);
}
