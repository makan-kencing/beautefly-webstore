package com.lavacorp.beautefly.webstore.search.dto;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.entity.Account_;
import com.lavacorp.beautefly.webstore.account.entity.Credential;
import com.lavacorp.beautefly.webstore.account.entity.Credential_;
import jakarta.annotation.Nullable;
import jakarta.data.page.PageRequest;
import jakarta.persistence.criteria.*;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.validation.constraints.Email;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.hibernate.query.Order;
import org.hibernate.query.criteria.HibernateCriteriaBuilder;

import java.util.List;
import java.util.stream.Collectors;

public record AccountSearchParametersDTO(
        @Nullable String query,  // both username and email
        @Nullable String username,
        @Nullable @Email String email,
        @Nullable List<Credential.Role> roles,
        @Nullable Boolean active,
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
            id(Account_.id),
            username(Account_.username),
            email(Account_.email),
            active(Account_.active);

            private final SingularAttribute<Account, ?> attribute;
        }

        public Order<? super Account> getOrder() {
            if (direction == Direction.asc)
                return Order.asc(by.getAttribute());
            return Order.desc(by.getAttribute());
        }
    }

    public Predicate toPredicate(Root<Account> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
        var builder = (HibernateCriteriaBuilder) cb;

        Predicate where = builder.conjunction();

        if (this.query != null)
            where = builder.and(
                    where,
                    builder.or(
                            builder.ilike(root.get(Account_.username), "%" + this.query + "%"),
                            builder.ilike(root.get(Account_.email), "%" + this.query + "%")
                    )
            );

        if (this.username != null)
            where = builder.and(
                    where,
                    builder.ilike(root.get(Account_.username), "%" + this.username + "%")
            );

        if (this.email != null)
            where = builder.and(
                    where,
                    builder.ilike(root.get(Account_.email), "%" + this.email + "%")
            );

        if (this.roles != null && !this.roles.isEmpty()) {
            Join<Account, Credential> credential = root.join(Account_.credential);
            Join<Credential, Credential.Role> roles = credential.join(Credential_.roles);
            where = builder.and(
                    where,
                    roles.in(this.roles)
            );
        }

        if (this.active != null)
            where = builder.and(
                    where,
                    builder.equal(root.get(Account_.active), this.active)
            );

        return where;
    }

    public List<Order<? super Account>> getOrders() {
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
