package com.lavacorp.beautefly.webstore.account;

import com.lavacorp.beautefly.webstore.account.dto.AddressDTO;
import com.lavacorp.beautefly.webstore.account.dto.AddressesDTO;
import com.lavacorp.beautefly.webstore.account.dto.UserAccountDetailsDTO;
import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.entity.Account_;
import com.lavacorp.beautefly.webstore.account.entity.AddressBook_;
import com.lavacorp.beautefly.webstore.account.mapper.AccountMapper;
import com.lavacorp.beautefly.webstore.account.mapper.AddressMapper;
import com.lavacorp.beautefly.webstore.security.dto.AccountContextDTO;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.transaction.Transactional;
import org.hibernate.SessionFactory;
import org.hibernate.graph.GraphSemantic;

import java.util.NoSuchElementException;

@Transactional
@ApplicationScoped
public class AccountService {
    @PersistenceUnit
    private EntityManagerFactory emf;

    @Inject
    private AccountMapper accountMapper;

    @Inject
    private AddressMapper addressMapper;

    public UserAccountDetailsDTO getUserAccountDetails(AccountContextDTO user) {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var account = session.get(Account.class, user.id());

        if (account == null)
            throw new NoSuchElementException("Account id does not exists.");

        return accountMapper.toUserAccountDetailsDTO(account);
    }

    public AddressesDTO getAccountAddressesDetails(AccountContextDTO user) {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var graph = session.createEntityGraph(Account.class);
        graph.addSubgraph(Account_.addressBook).addPluralSubgraph(AddressBook_.addresses);

        var account = session.get(graph, GraphSemantic.FETCH, user.id());

        if (account == null)
            throw new NoSuchElementException("Account id does not exists.");

        return addressMapper.toAddressesDTO(account.getAddressBook());
    }
}
