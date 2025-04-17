package com.lavacorp.beautefly.webstore.file;

import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.EntityPart;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

@Path("/file/upload")
public class FileResource {
    @Inject
    private FileService fileService;

    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces(MediaType.APPLICATION_JSON)
    public Response uploadFile(
            @FormParam("file") EntityPart part
    ) {
        var file = fileService.processFile(part);
        if (file == null)
            return Response.serverError()
                    .status(Response.Status.BAD_REQUEST)
                    .build();

        return Response.ok(file).build();
    }
}
