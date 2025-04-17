package com.lavacorp.beautefly.webstore.file;

import com.lavacorp.beautefly.webstore.account.AccountRepository;
import jakarta.annotation.security.RolesAllowed;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.*;

@RolesAllowed({"USER"})
@Path("/file/upload")
public class FileResource {
    @Context
    private SecurityContext securityContext;

    @Inject
    private FileService fileService;

    @Inject
    private AccountRepository accountRepository;

    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces(MediaType.APPLICATION_JSON)
    public Response uploadFile(
            @FormParam("file") EntityPart part
    ) {
        var principal = securityContext.getUserPrincipal();
        var account = accountRepository.findByEmail(principal.getName());

        if (account == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        var file = fileService.processFile(part, account);
        if (file == null)
            return Response.status(Response.Status.BAD_REQUEST).build();

        return Response.ok(file).build();
    }
}
