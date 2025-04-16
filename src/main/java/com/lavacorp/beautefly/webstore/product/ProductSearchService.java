package com.lavacorp.beautefly.webstore.product;

import com.lavacorp.beautefly.webstore.product.dto.*;
import com.lavacorp.beautefly.webstore.product.entity.Product;
import com.lavacorp.beautefly.webstore.product.entity.Product_;
import com.lavacorp.beautefly.webstore.product.mapper.ProductMapper;
import jakarta.data.page.Page;
import jakarta.data.page.impl.PageRecord;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceUnit;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.JoinType;
import jakarta.transaction.Transactional;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.SelectionQuery;
import org.hibernate.query.criteria.CriteriaDefinition;

import java.util.List;

@ApplicationScoped
@Transactional
public class ProductSearchService {
    @PersistenceUnit
    private EntityManagerFactory emf;

    @Inject
    private ProductMapper productMapper;

    public ProductSearchContextDTO search(ProductSearchDTO search) {
        // use statelessSession to not cache entities
        var statelessSession = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var builder = statelessSession.getCriteriaBuilder();

        CriteriaQuery<Product> criteria = new CriteriaDefinition<>(emf, Product.class) {{
            var root = from(Product.class);

            select(root);
            root.fetch(Product_.category, JoinType.LEFT);
            root.fetch(Product_.color, JoinType.LEFT);
            root.fetch(Product_.imageUrls, JoinType.LEFT);
            where(search.toPredicate(root, this, builder));
        }};

        SelectionQuery<Product> query = emf.createEntityManager()
                .unwrap(Session.class)
                .createSelectionQuery(criteria);
        if (search.sort() != null)
            query = query.setOrder(search.sort().getOrder());

        long total = query.getResultCount();
        List<Product> products = query
                .setFirstResult((search.page() - 1) * search.pageSize())
                .setMaxResults(search.pageSize())
                .getResultList();
        Page<ProductSearchResultDTO> page = new PageRecord<>(
                search.getPageRequest(),
                products.stream().map(productMapper::fromProduct).toList(),
                total
        );

        return new ProductSearchContextDTO(
                PaginatedResult.fromPaginated(page),
                search
        );
    }

    public ProductPageDTO getProductDetailsById(int id) {
        var em = emf.createEntityManager();

        Product product;
        try {
            product = em.find(Product.class, id);
        } catch (NoResultException e) {
            return null;
        }

        return productMapper.toProductPageDTO(product);
    }
}
