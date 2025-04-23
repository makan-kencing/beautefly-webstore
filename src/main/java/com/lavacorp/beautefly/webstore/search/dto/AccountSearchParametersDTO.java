package com.lavacorp.beautefly.webstore.search.dto;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.entity.Account_;
import com.lavacorp.beautefly.webstore.account.entity.Credential;
import com.lavacorp.beautefly.webstore.account.entity.Credential_;
import jakarta.annotation.Nullable;
import jakarta.data.page.PageRequest;
import jakarta.persistence.criteria.*;
import jakarta.validation.constraints.Email;
import jakarta.ws.rs.DefaultValue;
import jakarta.ws.rs.QueryParam;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import org.hibernate.query.Order;
import org.hibernate.query.criteria.HibernateCriteriaBuilder;

import java.util.List;

@Data
public class AccountSearchParametersDTO {
    @QueryParam("query") @Nullable String query;  // both username and email
    @QueryParam("username") @Nullable String username;
    @QueryParam("email") @Nullable @Email String email;
    @QueryParam("roles") @Nullable List<Credential.Role> roles;
    @QueryParam("active") @Nullable Boolean active;
    @QueryParam("page") @DefaultValue("1") int page = 1;
    @QueryParam("pageSize") @DefaultValue("50") int pageSize = 50;
    @QueryParam("sort") AccountSorter sort;

    @Getter
    @AllArgsConstructor
    public enum AccountSorter {
        id(Order.asc(Account_.id)),
        idDesc(Order.desc(Account_.id)),
        username(Order.asc(Account_.username)),
        usernameDesc(Order.desc(Account_.username)),
        email(Order.asc(Account_.email)),
        emailDesc(Order.desc(Account_.email)),
        active(Order.asc(Account_.active)),
        activeDesc(Order.desc(Account_.active));

        private final Order<Account> order;
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

    public PageRequest getPageRequest() {
        return PageRequest.ofPage(page, pageSize, true);
    }
}
