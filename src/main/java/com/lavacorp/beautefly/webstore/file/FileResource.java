package com.lavacorp.beautefly.webstore.file;

import jakarta.annotation.security.RolesAllowed;
import jakarta.inject.Inject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.EntityPart;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

@RolesAllowed({"USER"})
@Path("/file/upload")
public class FileResource {
    @Context
    private HttpServletRequest req;

    @Inject
    private FileService fileService;

    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces(MediaType.APPLICATION_JSON)
    public Response uploadFile(
            @FormParam("file") EntityPart part
    ) {
        var file = fileService.uploadFile(part, req);
        if (file == null)
            return Response.status(Response.Status.BAD_REQUEST).build();

        return Response.ok(file).build();
    }
}
