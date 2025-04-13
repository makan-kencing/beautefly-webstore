package com.lavacorp.beautefly.webstore.product;

import com.lavacorp.beautefly.webstore.product.entity.Product;
import jakarta.annotation.Nullable;
import jakarta.data.Order;
import jakarta.data.Sort;
import jakarta.data.page.Page;
import jakarta.data.page.PageRequest;
import jakarta.data.repository.*;
import jakarta.transaction.Transactional;
import org.hibernate.annotations.processing.Pattern;

@Repository
@Transactional
public interface ProductStatelessRepository {
    @Insert
    Product insert(Product product);

    @Find
    @Nullable
    Product find(int id);

    @Find
    Page<Product> findAll(PageRequest pageRequest, Order<Product> orderBy);

    @Find
    Page<Product> findAllByNameLike(@Pattern String name, PageRequest pageRequest, Order<Product> orderBy);

    @Delete
    void delete(Product product);

    @Delete
    void deleteById(int id);

    @Update
    Product update(Product product);
}
