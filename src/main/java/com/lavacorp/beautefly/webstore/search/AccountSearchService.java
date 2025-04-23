package com.lavacorp.beautefly.webstore.search;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.entity.Account_;
import com.lavacorp.beautefly.webstore.account.entity.Credential_;
import com.lavacorp.beautefly.webstore.account.mapper.AccountMapper;
import com.lavacorp.beautefly.webstore.common.dto.PaginatedResult;
import com.lavacorp.beautefly.webstore.search.dto.AccountSearchParametersDTO;
import com.lavacorp.beautefly.webstore.search.dto.AccountSearchResultDTO;
import jakarta.data.page.Page;
import jakarta.data.page.impl.PageRecord;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.JoinType;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.BeanParam;
import org.hibernate.SessionFactory;
import org.hibernate.query.SelectionQuery;
import org.hibernate.query.criteria.CriteriaDefinition;

import java.util.List;

@Transactional
@ApplicationScoped
public class AccountSearchService {
    @PersistenceUnit
    private EntityManagerFactory emf;

    @Inject
    private AccountMapper accountMapper;

    public PaginatedResult<AccountSearchResultDTO> search(@BeanParam AccountSearchParametersDTO search) {
        var sf = emf.unwrap(SessionFactory.class);
        var session = sf.openStatelessSession();

        var builder = session.getCriteriaBuilder();

        CriteriaQuery<Account> criteria = new CriteriaDefinition<>(emf, Account.class) {{
            var account = from(Account.class);

            select(account);
            account.fetch(Account_.credential, JoinType.LEFT)
                    .fetch(Credential_.roles, JoinType.LEFT);
            where(search.toPredicate(account, this, builder));
        }};

        long total = session.createSelectionQuery("from Account", Account.class)
                .getResultCount();

        SelectionQuery<Account> query = session.createSelectionQuery(criteria);
            query = query.setOrder(search.getOrders());

        long filteredTotal = query.getResultCount();

        List<Account> accounts = query
                .setFirstResult((search.page() - 1) * search.pageSize())
                .setMaxResults(search.pageSize())
                .getResultList();
        Page<AccountSearchResultDTO> page = new PageRecord<>(
                search.getPageRequest(),
                accounts.stream().map(accountMapper::toAccountSearchResultDTO).toList(),
                filteredTotal
        );

        return PaginatedResult.fromPaginated(page, (int) total);
    }
}
