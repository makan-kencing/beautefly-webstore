package com.lavacorp.beautefly.webstore.admin;

import com.lavacorp.beautefly.webstore.common.dto.PaginatedResult;
import com.lavacorp.beautefly.webstore.search.ProductSearchService;
import com.lavacorp.beautefly.webstore.search.dto.ProductSearchResultDTO;
import com.lavacorp.beautefly.webstore.search.mapper.SearchMapper;
import jakarta.inject.Inject;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.UriInfo;

@Path("/admin/product")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class AdminProductResource {
    @Inject
    private ProductSearchService productSearchService;

    @Inject
    private SearchMapper searchMapper;

    @GET
    @Path("/search")
    public PaginatedResult<ProductSearchResultDTO> searchAccount(@Context UriInfo uriInfo) {
        var query = searchMapper.toDataTablesParameters(uriInfo.getQueryParameters());
        var search = searchMapper.toProductSearchParameters(query);

        return productSearchService.search(search);
    }
}
