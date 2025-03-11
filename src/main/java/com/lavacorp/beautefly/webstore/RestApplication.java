package com.lavacorp.beautefly.webstore;

import jakarta.ws.rs.ApplicationPath;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.Application;

@ApplicationPath("/api")
@Path("/")
public class RestApplication extends Application {
    @GET
    @Path("ping")
    @Produces("text/plain")
    public String ping() {
        return "Pong";
    }
}
