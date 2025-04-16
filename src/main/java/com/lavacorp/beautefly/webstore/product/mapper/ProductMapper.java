package com.lavacorp.beautefly.webstore.product.mapper;

import com.lavacorp.beautefly.common.Range;
import com.lavacorp.beautefly.webstore.product.dto.ProductDTO;
import com.lavacorp.beautefly.webstore.product.dto.ProductSearchDTO;
import com.lavacorp.beautefly.webstore.product.entity.Product;
import jakarta.servlet.http.HttpServletRequest;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingConstants;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;

@Mapper(
        componentModel = MappingConstants.ComponentModel.CDI,
        uses = {CategoryMapper.class, ColorMapper.class}
)
public interface ProductMapper {
    ProductSearchDTO.ProductSorter DEFAULT_SORT = ProductSearchDTO.ProductSorter.id;
    int DEFAULT_PAGE = 1;
    int DEFAULT_PAGE_SIZE = 50;

    ProductDTO fromProduct(Product product);

    default ProductSearchDTO fromReq(HttpServletRequest req) {
        // TODO: do exception handling
        List<String> categories = null;
        var categoryValues = req.getParameterValues("categories");
        if (categoryValues != null)
            categories = Arrays.stream(categoryValues).toList();

        List<String> brands = null;
        var brandValues = req.getParameterValues("brands");
        if (brandValues != null)
            brands = Arrays.stream(brandValues).toList();

        List<String> colors = null;
        var colorValues = req.getParameterValues("colors");
        if (colorValues != null)
            colors = Arrays.stream(colorValues).toList();

        Range<BigDecimal> price = null;
        var priceLowValue = req.getParameter("price_low");
        var priceHighValue = req.getParameter("price_high");
        if (priceLowValue != null && priceHighValue != null)
            price = new Range<>(
                    new BigDecimal(priceLowValue),
                    new BigDecimal(priceHighValue)
            );

        Range<LocalDate> releaseDate = null;
        var dateLowValue = req.getParameter("releaseDate_low");
        var dateHighValue = req.getParameter("releaseDate_high");
        if (dateLowValue != null && dateHighValue != null)
            releaseDate = new Range<>(
                    LocalDate.parse(dateLowValue),
                    LocalDate.parse(dateHighValue)
            );

        int page = DEFAULT_PAGE;
        var pageValue = req.getParameter("page");
        if (pageValue != null)
            page = Integer.parseUnsignedInt(pageValue);

        int pageSize = DEFAULT_PAGE_SIZE;
        var pageSizeValue = req.getParameter("pageSize");
        if (pageSizeValue != null)
            pageSize = Integer.parseUnsignedInt(pageSizeValue);

        ProductSearchDTO.ProductSorter sort = DEFAULT_SORT;
        var sortValue = req.getParameter("sort");
        if (sortValue != null)
            sort = ProductSearchDTO.ProductSorter.valueOf(sortValue);

        return new ProductSearchDTO(
                req.getParameter("query"),
                categories,
                brands,
                price,
                releaseDate,
                colors,
                page,
                pageSize,
                sort
        );
    }
}
