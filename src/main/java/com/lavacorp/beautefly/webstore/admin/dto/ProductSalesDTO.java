package com.lavacorp.beautefly.webstore.admin.dto;

import com.lavacorp.beautefly.webstore.product.dto.ProductPageDTO;

import java.math.BigDecimal;

public record ProductSalesDTO (
        ProductPageDTO product,
        BigDecimal totalSales
){
}
