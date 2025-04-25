package com.lavacorp.beautefly.webstore.search.dto;

import com.lavacorp.beautefly.webstore.common.dto.Range;
import com.lavacorp.beautefly.webstore.product.entity.*;
import jakarta.annotation.Nullable;
import jakarta.data.page.PageRequest;
import jakarta.persistence.criteria.*;
import jakarta.persistence.metamodel.SingularAttribute;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.hibernate.query.Order;
import org.hibernate.query.criteria.HibernateCriteriaBuilder;

import java.math.BigDecimal;
import java.time.chrono.ChronoLocalDate;
import java.util.List;
import java.util.stream.Collectors;

// https://medium.com/@cmmapada/advanced-search-and-filtering-using-spring-data-jpa-specification-and-criteria-api-b6e8f891f2bf
// https://stackoverflow.com/questions/55919913/implement-search-filter-with-conditions
public record ProductSearchParametersDTO(
        @Nullable String query,  // fulltext search
        @Nullable String name,
        @Nullable List<String> categories,
        @Nullable List<String> brands,
        @Nullable Range<BigDecimal> price,
        @Nullable Range<ChronoLocalDate> releaseDate,
        @Nullable List<String> colors,
        int page,
        int pageSize,
        @Nullable List<Sorter> sort
) {
    public record Sorter(
            Attribute by,
            Direction direction
    ) {
        @Getter
        @AllArgsConstructor
        public enum Attribute {
            id(Product_.id),
            name(Product_.name),
            unitPrice(Product_.unitPrice),
            unitCost(Product_.unitCost),
            brand(Product_.brand),
            stockCount(Product_.stockCount),
            releaseDate(Product_.releaseDate);

            private final SingularAttribute<Product, ?> attribute;
        }

        public Order<? super Product> getOrder() {
            if (direction == Direction.asc)
                return Order.asc(by.getAttribute());
            return Order.desc(by.getAttribute());
        }
    }

    public Predicate toPredicate(Root<Product> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
        var builder = (HibernateCriteriaBuilder) cb;

        Predicate where = builder.conjunction();  // empty predicate

        if (this.query != null) {
            Join<Product, Category> category = root.join(Product_.category, JoinType.LEFT);
            Join<Product, Color> color = root.join(Product_.color, JoinType.LEFT);
            where = builder.and(
                    where,
                    builder.or(
                            builder.ilike(root.get(Product_.name), "%" + this.query + "%"),
                            builder.ilike(root.get(Product_.brand), "%" + this.query + "%"),
                            builder.ilike(category.get(Category_.name), "%" + this.query + "%"),
                            builder.ilike(color.get(Color_.name), "%" + this.query + "%")
                    )
            );
        }

        if (this.name != null)
            where = builder.and(
                    where,
                    builder.ilike(root.get(Product_.name), "%" + this.name + "%")
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

    public List<Order<? super Product>> getOrders() {
        if (sort == null)
            return List.of();

        return sort.stream()
                .map(Sorter::getOrder)
                .collect(Collectors.toList());
    }

    public PageRequest getPageRequest() {
        return PageRequest.ofPage(page, pageSize, true);
    }
}
