package com.lavacorp.beautefly.webstore.admin;

import com.lavacorp.beautefly.webstore.account.AccountRepository;
import com.lavacorp.beautefly.webstore.account.dto.CreateUserAccountDTO;
import com.lavacorp.beautefly.webstore.account.dto.UpdateUserAccountDTO;
import com.lavacorp.beautefly.webstore.account.entity.UserAccount;
import com.lavacorp.beautefly.webstore.account.mapper.AccountMapper;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import jakarta.security.enterprise.identitystore.PasswordHash;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.hibernate.exception.ConstraintViolationException;

import java.util.HashSet;

@Path("/admin/account")
@Transactional
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class AdminAccountResource {
    @Inject
    private AccountRepository accountRepository;

    @Inject
    private AccountMapper accountMapper;

    @Inject
    @Named("Argon2idPasswordHash")
    private PasswordHash passwordHash;

    @POST
    public Response createAccount(CreateUserAccountDTO dto) {
        var account = new UserAccount();
        account.setUsername(dto.username());
        account.setEmail(dto.email());

        var credential = account.getCredential();
        credential.setPassword(passwordHash.generate(dto.password().toCharArray()));
        credential.setRoles(new HashSet<>(dto.roles()));

        try {
            var created = accountRepository.register(account);

            return Response.ok(accountMapper.toUserAccountDetailsDTO(created)).build();
        } catch (ConstraintViolationException e) {
            return Response.status(Response.Status.CONFLICT).build();
        }
    }

    @GET
    @Path("/search")
    public Response searchAccount() {
        return Response.ok().build();
    }

    @PUT
    @Path("/{id}")
    public Response updateAccount(@PathParam("id") int id, UpdateUserAccountDTO dto) {
        var account = accountRepository.findUserAccount(id);
        if (account == null)
            return Response.status(Response.Status.NOT_FOUND).build();

        account = accountMapper.partialUpdate(dto, account);

        try {
            accountRepository.update(account);
            return Response.ok(accountMapper.toUserAccountDetailsDTO(account)).build();
        } catch (ConstraintViolationException e) {
            return Response.status(Response.Status.CONFLICT).build();
        }
    }

    @DELETE
    @Path("/{id}")
    public void deleteAccount(@PathParam("id") int id) {
        accountRepository.deleteById(id);
    }
}
