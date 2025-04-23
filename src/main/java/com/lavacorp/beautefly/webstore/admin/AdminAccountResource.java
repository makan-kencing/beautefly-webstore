package com.lavacorp.beautefly.webstore.admin;

import com.lavacorp.beautefly.webstore.common.dto.PaginatedResult;
import com.lavacorp.beautefly.webstore.search.AccountSearchService;
import com.lavacorp.beautefly.webstore.search.dto.AccountSearchResultDTO;
import com.lavacorp.beautefly.webstore.search.mapper.SearchMapper;
import jakarta.inject.Inject;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.UriInfo;

@Path("/admin/account")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class AdminAccountResource {
    @Inject
    private AccountSearchService accountSearchService;

    @Inject
    private SearchMapper searchMapper;

    @GET
    @Path("/search")
    public PaginatedResult<AccountSearchResultDTO> searchAccount(@Context UriInfo uriInfo) {
        var query = searchMapper.toDataTablesParameters(uriInfo.getQueryParameters());
        var search = searchMapper.toAccountSearchParameters(query);

        return accountSearchService.search(search);
    }
}
