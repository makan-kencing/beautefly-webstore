package com.lavacorp.beautefly.webstore.account;

import com.lavacorp.beautefly.webstore.account.dto.AccountRegisterDTO;
import com.lavacorp.beautefly.webstore.account.entity.Account;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.*;

import java.util.List;

@Path("/account")
@ApplicationScoped
@Transactional
public class AccountController {
    @Inject
    private AccountRepository accountRepository;

    @GET
    @Produces("application/json")
    public List<Account> getAllAccounts() {
        return accountRepository.findAll();
    }

    @POST
    @Consumes("application/json")
    public void register(AccountRegisterDTO account) {
        var newUser = new Account();
        newUser.setUsername(account.username);
        newUser.setPassword(account.password);

        accountRepository.insert(newUser);
    }
}