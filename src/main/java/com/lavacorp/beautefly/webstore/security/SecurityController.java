package com.lavacorp.beautefly.webstore.security;

import com.lavacorp.beautefly.webstore.account.AccountRepository;
import com.lavacorp.beautefly.webstore.account.dto.AccountLoginDTO;
import com.lavacorp.beautefly.webstore.account.dto.AccountRegisterDTO;
import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.entity.Credential;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import jakarta.security.enterprise.identitystore.PasswordHash;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.hibernate.exception.ConstraintViolationException;

@Path("/account")
@ApplicationScoped
@Transactional
@Consumes({MediaType.APPLICATION_JSON, MediaType.APPLICATION_FORM_URLENCODED})
@Produces(MediaType.APPLICATION_JSON)
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
    public Response login(AccountLoginDTO loginAccount) {
        try {
            req.login(loginAccount.getEmail(), loginAccount.getPassword());
        } catch (ServletException exc) {
            return Response.status(Response.Status.FORBIDDEN).build();
        }
        return Response.ok().build();
    }

    @GET
    @Path("/logout")
    public Response logout() {
        try {
            req.logout();
        } catch (ServletException ignored) {

        }
        return Response.ok().build();
    }

    @POST
    @Path("/register")
    public Response register(AccountRegisterDTO registerAccount) {
        try {
            var account = new Account();
            var credential = new Credential();

            account.setUsername(registerAccount.getUsername());
            account.setEmail(registerAccount.getEmail());
            account.setDob(registerAccount.getDob());

            credential.setPassword(passwordHash.generate(registerAccount.getPassword().toCharArray()));
            account.setCredential(credential);

            accountRepository.register(account);

            return Response.status(Response.Status.CREATED).build();
        } catch (ConstraintViolationException exc) {
            return Response.status(Response.Status.CONFLICT).build();
        }
    }
}