package com.lavacorp.beautefly.webstore.product;

import com.lavacorp.beautefly.webstore.product.dto.PaginatedResult;
import com.lavacorp.beautefly.webstore.product.dto.ProductSearchContext;
import com.lavacorp.beautefly.webstore.product.dto.ProductSearchDTO;
import jakarta.data.Order;
import jakarta.data.page.PageRequest;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;

@ApplicationScoped
@Transactional
public class ProductSearchService {
    @Inject
    private ProductStatelessRepository statelessRepository;

    public ProductSearchContext search(ProductSearchDTO search) {
        var page = statelessRepository.findAllByNameLike(
                search.query(),
                PageRequest.ofPage(search.page(), search.pageSize(), true),
                Order.by(search.sort().getCond())
        );

        return new ProductSearchContext(
                PaginatedResult.fromPaginated(page),
                search
        );
    }
}
