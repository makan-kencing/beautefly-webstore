package com.lavacorp.beautefly.webstore.product.dto;

import com.lavacorp.beautefly.webstore.common.dto.Range;
import com.lavacorp.beautefly.webstore.product.entity.*;
import jakarta.annotation.Nullable;
import jakarta.data.page.PageRequest;
import jakarta.persistence.criteria.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.hibernate.query.Order;
import org.hibernate.query.criteria.HibernateCriteriaBuilder;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

// https://medium.com/@cmmapada/advanced-search-and-filtering-using-spring-data-jpa-specification-and-criteria-api-b6e8f891f2bf
// https://stackoverflow.com/questions/55919913/implement-search-filter-with-conditions
public record ProductSearchDTO(
        @Nullable String query,
        @Nullable List<String> categories,
        @Nullable List<String> brands,
        @Nullable Range<BigDecimal> price,
        @Nullable Range<LocalDate> releaseDate,
        @Nullable List<String> colors,
        int page,
        int pageSize,
        ProductSorter sort
) {
    @Getter
    @AllArgsConstructor
    public enum ProductSorter {
        id(Order.asc(Product_.id)),
        idDesc(Order.desc(Product_.id)),
        name(Order.asc(Product_.name)),
        nameDesc(Order.desc(Product_.name)),
        price(Order.asc(Product_.unitPrice)),
        priceDesc(Order.desc(Product_.unitPrice));

        private final Order<Product> order;
    }

    public Predicate toPredicate(Root<Product> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
        var builder = (HibernateCriteriaBuilder) cb;

        Predicate where = builder.conjunction();  // empty predicate

        if (this.query != null)
            where = builder.and(
                    where,
                    builder.ilike(root.get(Product_.name), "%" + this.query + "%")
            );

        if (this.categories != null) {
            Join<Product, Category> category = root.join(Product_.category);
            where = builder.and(
                    where,
                    builder.in(category.get(Category_.name), categories)
            );
        }

        if (this.brands != null)
            where = builder.and(
                    where,
                    builder.in(root.get(Product_.brand), brands)
            );

        if (this.price != null)
            where = builder.and(
                    where,
                    builder.between(root.get(Product_.unitPrice), this.price.low(), this.price.high())
            );

        if (this.releaseDate != null)
            where = builder.and(
                    where,
                    builder.between(root.get(Product_.releaseDate), this.releaseDate.low(), this.releaseDate.high())
            );

        if (this.colors != null) {
            Join<Product, Color> color = root.join(Product_.color);
            where = builder.and(
                    where,
                    builder.in(color.get(Color_.name), colors)
            );
        }

        return where;
    }

    public PageRequest getPageRequest() {
        return PageRequest.ofPage(page, pageSize, true);
    }
}
