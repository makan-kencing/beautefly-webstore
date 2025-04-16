package com.lavacorp.beautefly.webstore.product.servlet;

import com.lavacorp.beautefly.webstore.product.ProductSearchService;
import jakarta.inject.Inject;
import jakarta.mvc.Controller;
import jakarta.mvc.Models;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;

@Controller
@Path("/product")
public class ProductResource {
    @Inject
    private ProductSearchService productService;

    @Inject
    private Models models;

    @GET
    @Path("/{productId}/{slug}")
    public String getProduct(@PathParam("productId") int productId) {
        var product = productService.getProductDetailsById(productId);

        models.put("product", product);

        return "product.jsp";
    }
}
