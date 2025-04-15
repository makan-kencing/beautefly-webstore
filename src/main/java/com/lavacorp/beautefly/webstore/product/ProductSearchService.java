package com.lavacorp.beautefly.webstore.product;

import com.lavacorp.beautefly.webstore.product.dto.PaginatedResult;
import com.lavacorp.beautefly.webstore.product.dto.ProductDTO;
import com.lavacorp.beautefly.webstore.product.dto.ProductSearchDTO;
import com.lavacorp.beautefly.webstore.product.dto.ProductSearchResultDTO;
import com.lavacorp.beautefly.webstore.product.entity.Product;
import com.lavacorp.beautefly.webstore.product.mapper.ProductMapper;
import jakarta.data.page.Page;
import jakarta.data.page.impl.PageRecord;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Order;
import jakarta.transaction.Transactional;
import org.hibernate.Session;
import org.hibernate.query.SelectionQuery;
import org.hibernate.query.criteria.CriteriaDefinition;
import org.hibernate.query.criteria.HibernateCriteriaBuilder;

import java.util.stream.Stream;

@ApplicationScoped
@Transactional
public class ProductSearchService {
    @PersistenceUnit
    private EntityManagerFactory emf;

    @Inject
    private ProductMapper productMapper;

    public ProductSearchResultDTO search(ProductSearchDTO search) {
        var builder = (HibernateCriteriaBuilder) emf.getCriteriaBuilder();

        CriteriaQuery<Product> criteria = new CriteriaDefinition<>(emf, Product.class) {{
            var root = from(Product.class);

            select(root);
            where(search.toPredicate(root, this, builder));

            if (search.sort() != null)
                orderBy((Order) search.sort().getOrder());
        }};

        SelectionQuery<Product> query = emf.createEntityManager()
                .unwrap(Session.class)
                .createSelectionQuery(criteria);

        long total = query.getResultCount();
        Stream<Product> products = query
                .setFirstResult((search.page() - 1) * search.pageSize())
                .setMaxResults(search.pageSize())
                .getResultStream();
        Page<ProductDTO> page = new PageRecord<>(
                search.getPageRequest(),
                products.map(productMapper::fromProduct).toList(),
                total
        );

        return new ProductSearchResultDTO(
                PaginatedResult.fromPaginated(page),
                search
        );
    }
}
