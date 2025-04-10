package com.lavacorp.beautefly.webstore.security;

import com.lavacorp.beautefly.webstore.account.AccountRepository;
import com.lavacorp.beautefly.webstore.account.entity.UserAccount;
import com.lavacorp.beautefly.webstore.security.dto.AccountLoginDTO;
import com.lavacorp.beautefly.webstore.security.dto.AccountRegisterDTO;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import jakarta.security.enterprise.identitystore.PasswordHash;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.apache.logging.log4j.Logger;
import org.hibernate.exception.ConstraintViolationException;

@Path("/account")
@ApplicationScoped
@Transactional
@Consumes({MediaType.APPLICATION_JSON, MediaType.APPLICATION_FORM_URLENCODED})
@Produces(MediaType.APPLICATION_JSON)
public class SecurityController {
    @Inject
    private Logger logger;

    @Inject
    private AccountRepository accountRepository;

    @Inject
    @Named("Argon2idPasswordHash")
    private PasswordHash passwordHash;

    @Context
    private HttpServletRequest req;

    @POST
    @Path("/login")
    public Response login(@Valid AccountLoginDTO loginAccount) {
        try {
            req.login(loginAccount.email(), loginAccount.password());
        } catch (ServletException exc) {
            logger.error(exc);
            return Response.status(Response.Status.FORBIDDEN).build();
        }
        return Response.ok().build();
    }

    @GET
    @Path("/logout")
    public Response logout() {
        try {
            req.logout();
        } catch (ServletException exc) {
            logger.error(exc);
        }
        return Response.ok().build();
    }

    @POST
    @Path("/register")
    public Response register(@Valid AccountRegisterDTO registerAccount) {
        try {
            var account = new UserAccount();

            account.setUsername(registerAccount.username());
            account.setEmail(registerAccount.email());
            account.getCredential().setPassword(passwordHash.generate(registerAccount.password().toCharArray()));

            accountRepository.register(account);

            return Response.status(Response.Status.CREATED).build();
        } catch (ConstraintViolationException exc) {
            logger.warn(exc);
            return Response.status(Response.Status.CONFLICT).build();
        }
    }
}