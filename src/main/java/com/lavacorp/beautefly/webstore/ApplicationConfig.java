package com.lavacorp.beautefly.webstore;

import jakarta.annotation.security.DeclareRoles;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.security.enterprise.authentication.mechanism.http.FormAuthenticationMechanismDefinition;
import jakarta.security.enterprise.authentication.mechanism.http.LoginToContinue;
import jakarta.ws.rs.ApplicationPath;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.Application;
import jakarta.ws.rs.core.MediaType;

@FormAuthenticationMechanismDefinition(
        loginToContinue = @LoginToContinue(
                loginPage = "/WEB-INF/views/login.jsp",
                errorPage = "/login?error"
        )
)
@DeclareRoles({"USER", "STAFF", "ADMIN"})
@ApplicationScoped
@ApplicationPath("/api")
public class ApplicationConfig extends Application {
    public record PingResponse(String status) {
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public PingResponse ping() {
        return new PingResponse("ok");
    }
}
