package com.lavacorp.beautefly.webstore.security;

import com.lavacorp.beautefly.webstore.security.dto.AccountLoginDTO;
import com.lavacorp.beautefly.webstore.security.dto.AccountRegisterDTO;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import lombok.extern.log4j.Log4j2;
import org.hibernate.exception.ConstraintViolationException;

@Log4j2
@Path("/account")
@Consumes({MediaType.APPLICATION_JSON, MediaType.APPLICATION_FORM_URLENCODED})
@Produces(MediaType.APPLICATION_JSON)
public class SecurityResource {
    @Inject
    private SecurityService securityService;

    @Context
    private HttpServletRequest req;

    @POST
    @Path("/login")
    public Response login(@Valid AccountLoginDTO loginAccount) {
        try {
            req.login(loginAccount.email(), loginAccount.password());
        } catch (ServletException exc) {
            log.error(exc);
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
            log.error(exc);
        }
        return Response.ok().build();
    }

    @POST
    @Path("/register")
    public Response register(@Valid AccountRegisterDTO registration) {
        try {
            securityService.register(registration);
            return Response.status(Response.Status.CREATED).build();
        } catch (ConstraintViolationException exc) {
            log.warn(exc);
            return Response.status(Response.Status.CONFLICT).build();
        }
    }
}