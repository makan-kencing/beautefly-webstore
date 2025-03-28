package com.lavacorp.beautefly.webstore.security;

import com.lavacorp.beautefly.webstore.account.AccountRepository;
import com.lavacorp.beautefly.webstore.account.dto.AccountLoginDTO;
import com.lavacorp.beautefly.webstore.account.dto.AccountRegisterDTO;
import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.security.entity.Credential;
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

    @Context
    private HttpServletRequest req;

    @POST
    @Path("/login")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response login(AccountLoginDTO loginAccount) {
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
    public Response logout() {
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
            var credential = account.getCredential();

            account.setUsername(registerAccount.getUsername());
            account.setEmail(registerAccount.getEmail());
            account.setDob(registerAccount.getDob());

            credential.setPassword(passwordHash.generate(registerAccount.getPassword().toCharArray()));
            credential.setRoles(Set.of(Credential.Role.USER));

            accountRepository.insert(account);

            return Response.status(Response.Status.CREATED).build();
        } catch (ConstraintViolationException exc) {
            return Response.status(Response.Status.CONFLICT).build();
        }
    }
}