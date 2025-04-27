package com.lavacorp.beautefly.webstore.account;

import com.lavacorp.beautefly.webstore.account.dto.AddressDTO;
import com.lavacorp.beautefly.webstore.account.dto.AddressesDTO;
import com.lavacorp.beautefly.webstore.account.dto.UserAccountDetailsDTO;
import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.entity.Account_;
import com.lavacorp.beautefly.webstore.account.entity.Address;
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
            throw new NoSuchElementException("Account does not exists.");

        return addressMapper.toAddressesDTO(account.getAddressBook());
    }

    public boolean checkAddressOwnership(int accountId, int addressId) {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var count = session.createSelectionQuery("""
                from Address
                where account.id = :accountId
                    and id = :addressId
                """, Address.class)
                .setParameter("accountId", accountId)
                .setParameter("addressId", addressId)
                .getResultCount();

        return count > 0;
    }

    public AddressDTO getAddressDetails(int addressId) {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var address = session.get(Address.class, addressId);

        if (address == null)
            throw new NoSuchElementException("Address does not exists.");

        return addressMapper.toAddressDTO(address);
    }

    public void createNewAddress(AccountContextDTO user, AddressDTO newAddress) {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var account = session.get(Account.class, user.id());

        if (account == null)
            throw new NoSuchElementException("Account does not exists.");

        var address = addressMapper.toAddress(newAddress);
        address.setAccount(account);

        session.insert(address);

        if (account.getAddressBook().getDefaultAddress() == null) {
            account.getAddressBook().setDefaultAddress(address);
            session.update(account);
        }
    }

    public void setDefaultAddress(AccountContextDTO user, int addressId) {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var account = session.get(Account.class, user.id());

        if (account == null)
            throw new NoSuchElementException("Account does not exists.");

        var address = new Address();
        address.setId(addressId);

        account.getAddressBook().setDefaultAddress(address);
    }

    public void updateAddressDetails(AddressDTO updatedAddress) {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var address = session.get(Address.class, updatedAddress.id());

        if (address == null)
            throw new NoSuchElementException("Address does not exists.");

        address = addressMapper.partialUpdate(updatedAddress, address);

        session.update(address);
    }

    public void deleteAddress(int addressId) {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var address = session.get(Address.class, addressId);

        if (address == null)
            throw new NoSuchElementException("Address does not exists.");

        session.delete(address);
    }
}
