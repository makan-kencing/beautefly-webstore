package com.lavacorp.beautefly.webstore.security;

import com.lavacorp.beautefly.webstore.account.AccountRepository;
import com.lavacorp.beautefly.webstore.account.dto.AccountLoginDTO;
import com.lavacorp.beautefly.webstore.account.dto.AccountRegisterDTO;
import com.lavacorp.beautefly.webstore.account.entity.Account;
import jakarta.annotation.security.RolesAllowed;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import jakarta.security.enterprise.identitystore.PasswordHash;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.DELETE;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.hibernate.exception.ConstraintViolationException;

import java.util.Set;

@Path("/account")
@ApplicationScoped
@Transactional
public class SecurityController {
    @Inject
    private AccountRepository accountRepository;

    @Inject
    @Named("Argon2idPasswordHash")
    private PasswordHash passwordHash;

    @POST
    @Path("/login")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response login(AccountLoginDTO loginAccount, @Context HttpServletRequest req) {
        try {
            req.login(loginAccount.getEmail(), loginAccount.getPassword());
        } catch (ServletException exc) {
            return Response.status(Response.Status.FORBIDDEN).build();
        }
        return Response.ok().build();
    }

    @DELETE
    @RolesAllowed({"USER"})
    @Path("/logout")
    public Response logout(@Context HttpServletRequest req) {
        try {
            req.logout();
        } catch (ServletException ignored) {

        }
        return Response.ok().build();
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Path("/register")
    public Response register(AccountRegisterDTO registerAccount) {
        try {
            var account = new Account();

            account.setUsername(registerAccount.getUsername());
            account.setEmail(registerAccount.getEmail());
            account.setPassword(passwordHash.generate(registerAccount.getPassword().toCharArray()));
            account.setDob(registerAccount.getDob());

            account.setRoles(Set.of(Account.Role.USER));

            accountRepository.insert(account);

            return Response.status(Response.Status.CREATED).build();
        } catch (ConstraintViolationException exc) {
            return Response.status(Response.Status.CONFLICT).build();
        }
    }
}