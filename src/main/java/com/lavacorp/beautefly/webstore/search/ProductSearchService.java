package com.lavacorp.beautefly.webstore.search;

import com.lavacorp.beautefly.webstore.common.dto.PaginatedResult;
import com.lavacorp.beautefly.webstore.product.dto.ProductPageDTO;
import com.lavacorp.beautefly.webstore.search.dto.ProductSearchContextDTO;
import com.lavacorp.beautefly.webstore.search.dto.ProductSearchDTO;
import com.lavacorp.beautefly.webstore.search.dto.ProductSearchResultDTO;
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
        var sf = emf.unwrap(SessionFactory.class);
        var session = sf.openStatelessSession();

        var builder = session.getCriteriaBuilder();

        CriteriaQuery<Product> criteria = new CriteriaDefinition<>(sf, Product.class) {{
            var product = from(Product.class);

            select(product);
            product.fetch(Product_.category, JoinType.LEFT);
            product.fetch(Product_.color, JoinType.LEFT);
            product.fetch(Product_.images, JoinType.LEFT);

            where(search.toPredicate(product, this, builder));
        }};

        long total = session.createSelectionQuery("from Product", Product.class)
                .getResultCount();

        SelectionQuery<Product> query = session.createSelectionQuery(criteria);
        if (search.sort() != null)
            query = query.setOrder(search.sort().getOrder());

        long filteredTotal = query.getResultCount();

        List<Product> products = query
                .setFirstResult((search.page() - 1) * search.pageSize())
                .setMaxResults(search.pageSize())
                .getResultList();
        Page<ProductSearchResultDTO> page = new PageRecord<>(
                search.getPageRequest(),
                products.stream().map(productMapper::fromProduct).toList(),
                filteredTotal
        );

        return new ProductSearchContextDTO(
                PaginatedResult.fromPaginated(page, (int) total),
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
