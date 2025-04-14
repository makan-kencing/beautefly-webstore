package com.lavacorp.beautefly.webstore.product.dto;

import com.lavacorp.beautefly.webstore.product.entity.Product;
import com.lavacorp.beautefly.webstore.product.entity._Product;
import jakarta.annotation.Nullable;
import jakarta.data.Sort;
import jakarta.validation.constraints.Min;
import jakarta.ws.rs.DefaultValue;
import jakarta.ws.rs.QueryParam;
import lombok.AllArgsConstructor;
import lombok.Getter;


public record ProductSearchDTO(
        @QueryParam("query") String query,
        @QueryParam("page") @DefaultValue("1") @Min(1) int page,
        @QueryParam("pageSize") @DefaultValue("50") @Min(1) int pageSize,
        @QueryParam("sort") @DefaultValue("id") SortBy sort
) {
    @Getter
    @AllArgsConstructor
    public enum SortBy {
        id(_Product.id.asc()),
        idDesc(_Product.id.desc()),
        name(_Product.name.ascIgnoreCase()),
        nameDesc(_Product.name.descIgnoreCase()),
        category(_Product.category.ascIgnoreCase()),
        categoryDesc(_Product.category.descIgnoreCase()),
        price(_Product.unitPrice.asc()),
        priceDesc(_Product.unitPrice.desc());

        private final Sort<Product> cond;
    }
}
