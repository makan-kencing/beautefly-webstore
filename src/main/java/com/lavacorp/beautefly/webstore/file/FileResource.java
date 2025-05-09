package com.lavacorp.beautefly.webstore.file;

import com.lavacorp.beautefly.util.jaxrs.exception.UnprocessableEntityException;
import com.lavacorp.beautefly.webstore.file.dto.FileUploadDTO;
import com.lavacorp.beautefly.webstore.file.exception.UnsupportedFileFormatException;
import com.lavacorp.beautefly.webstore.security.filter.UserContextFilter;
import jakarta.annotation.security.RolesAllowed;
import jakarta.inject.Inject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.EntityPart;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.io.IOException;

@RolesAllowed({"*"})
@Path("/file/upload")
public class FileResource {
    @Context
    private HttpServletRequest req;

    @Inject
    private FileService fileService;

    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces(MediaType.APPLICATION_JSON)
    public FileUploadDTO uploadFile(
            @FormParam("file") EntityPart part
    ) {
        var user = UserContextFilter.getUserContext(req);
        if (user == null)
            throw new ForbiddenException();

        try {
            return fileService.uploadFile(part.getContent(), part.getFileName().orElse(null), user);
        } catch (UnsupportedFileFormatException e) {
            var format = "File format";
            if (e.getMimeType() != null)
                format = e.getMimeType().getName();

            throw new UnprocessableEntityException(format + " is not supported.");
        } catch (IOException e) {
            throw new ServerErrorException("Error while creating file", Response.Status.INTERNAL_SERVER_ERROR);
        }
    }
}
