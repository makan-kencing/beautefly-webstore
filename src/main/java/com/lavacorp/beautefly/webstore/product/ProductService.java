package com.lavacorp.beautefly.webstore.product;

import com.lavacorp.beautefly.webstore.product.dto.CategoryDTO;
import com.lavacorp.beautefly.webstore.product.dto.CategoryTreeDTO;
import com.lavacorp.beautefly.webstore.product.dto.ColorDTO;
import com.lavacorp.beautefly.webstore.product.entity.Category;
import com.lavacorp.beautefly.webstore.product.entity.Color;
import com.lavacorp.beautefly.webstore.product.mapper.CategoryMapper;
import com.lavacorp.beautefly.webstore.product.mapper.ColorMapper;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.transaction.Transactional;
import org.hibernate.SessionFactory;

import java.util.List;

@Transactional
@ApplicationScoped
public class ProductService {
    @PersistenceUnit
    private EntityManagerFactory emf;

    @Inject
    private CategoryMapper categoryMapper;

    @Inject
    private ColorMapper colorMapper;

    public List<CategoryDTO> getAvailableCategories() {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        return session.createSelectionQuery("""        
                        from Category
                        """, Category.class)
                .stream()
                .map(categoryMapper::toCategoryDTO)
                .toList();
    }

    public List<CategoryTreeDTO> getAvailableCategoryTree() {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        // how tf u write a recursive fetch
        return session.createSelectionQuery("""     
                        from Category c
                            left join fetch c.subcategories cc
                            left join fetch cc.subcategories ccc
                        where c.parent is null
                        """, Category.class)
                .stream()
                .map(categoryMapper::toCategoryTreeDTO)
                .toList();
    }

    public List<ColorDTO> getAvailableColors() {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        return session.createSelectionQuery("from Color", Color.class)
                .stream()
                .map(colorMapper::toColorDTO)
                .toList();
    }

    public List<String> getExistingBrands() {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        return session.createSelectionQuery("select distinct brand from Product", String.class)
                .getResultList();
    }
}
