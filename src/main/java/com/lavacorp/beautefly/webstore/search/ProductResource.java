package com.lavacorp.beautefly.webstore.search;

import com.lavacorp.beautefly.webstore.search.dto.ProductSearchContextDTO;
import com.lavacorp.beautefly.webstore.search.dto.ProductSearchDTO;
import jakarta.inject.Inject;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Path("/product")
@Consumes({MediaType.APPLICATION_JSON, MediaType.APPLICATION_FORM_URLENCODED})
@Produces(MediaType.APPLICATION_JSON)
public class ProductResource {
    @Inject
    private ProductSearchService productSearchService;

    @GET
    @Path("/search")
    public ProductSearchContextDTO searchProducts(ProductSearchDTO search) {
        return productSearchService.search(search);
    }
}
