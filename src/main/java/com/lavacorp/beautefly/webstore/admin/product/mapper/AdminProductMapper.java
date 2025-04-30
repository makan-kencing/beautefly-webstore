package com.lavacorp.beautefly.webstore.admin.product.mapper;

import com.lavacorp.beautefly.webstore.admin.product.dto.*;
import com.lavacorp.beautefly.webstore.product.entity.Product;
import com.lavacorp.beautefly.webstore.product.mapper.CategoryMapper;
import com.lavacorp.beautefly.webstore.product.mapper.ColorMapper;
import com.lavacorp.beautefly.webstore.rating.mapper.RatingMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Optional;

@Mapper(
        componentModel = MappingConstants.ComponentModel.CDI,
        uses = {CategoryMapper.class, ColorMapper.class, RatingMapper.class}
)
public interface AdminProductMapper {
    ProductDetailsDTO toProductDetailsDTO(Product product);

    default CreateProductDTO toCreateProductDTO(HttpServletRequest req) {
        return new CreateProductDTO(
                req.getParameter("name"),
                req.getParameter("description"),
                req.getParameter("brand"),
                Optional.ofNullable(req.getParameter("categoryId"))
                        .filter(s -> !s.isBlank())
                        .map(Integer::parseUnsignedInt)
                        .orElse(null),
                Optional.ofNullable(req.getParameter("colorId"))
                        .filter(s -> !s.isBlank())
                        .map(Integer::parseUnsignedInt)
                        .orElse(null),
                Optional.ofNullable(req.getParameter("releaseDate"))
                        .filter(s -> !s.isBlank())
                        .map(LocalDate::parse)
                        .orElse(null),
                Optional.ofNullable(req.getParameter("unitPrice"))
                        .filter(s -> !s.isBlank())
                        .map(BigDecimal::new)
                        .orElse(null),
                Optional.ofNullable(req.getParameter("unitCost"))
                        .filter(s -> !s.isBlank())
                        .map(BigDecimal::new)
                        .orElse(null),
                Optional.ofNullable(req.getParameter("stockCount"))
                        .filter(s -> !s.isBlank())
                        .map(Integer::parseUnsignedInt)
                        .orElse(0)
        );
    }

    default EditProductDTO toEditProductDTO(HttpServletRequest req) {
        return new EditProductDTO(
                Optional.ofNullable(req.getParameter("id"))
                        .filter(s -> !s.isBlank())
                        .map(Integer::parseUnsignedInt)
                        .orElseThrow(),
                req.getParameter("name"),
                req.getParameter("description"),
                req.getParameter("brand"),
                Optional.ofNullable(req.getParameter("categoryId"))
                        .filter(s -> !s.isBlank())
                        .map(Integer::parseUnsignedInt)
                        .orElse(null),
                Optional.ofNullable(req.getParameter("colorId"))
                        .filter(s -> !s.isBlank())
                        .map(Integer::parseUnsignedInt)
                        .orElse(null),
                Optional.ofNullable(req.getParameter("releaseDate"))
                        .filter(s -> !s.isBlank())
                        .map(LocalDate::parse)
                        .orElse(null),
                Optional.ofNullable(req.getParameter("unitPrice"))
                        .filter(s -> !s.isBlank())
                        .map(BigDecimal::new)
                        .orElse(null),
                Optional.ofNullable(req.getParameter("unitCost"))
                        .filter(s -> !s.isBlank())
                        .map(BigDecimal::new)
                        .orElse(null),
                Optional.ofNullable(req.getParameter("stockCount"))
                        .filter(s -> !s.isBlank())
                        .map(Integer::parseUnsignedInt)
                        .orElse(0)
        );
    }

    default DeleteProductDTO toDeleteProductDTO(HttpServletRequest req) {
        return new DeleteProductDTO(
                Optional.ofNullable(req.getParameterValues("id"))
                        .map(s -> Arrays.stream(s)
                                .map(Integer::parseUnsignedInt)
                                .toList()
                        ).orElse(new ArrayList<>())
        );
    }

    default UploadProductImageDTO toUploadProductImageDTO(HttpServletRequest req) throws ServletException, IOException {
        return new UploadProductImageDTO(
                Optional.ofNullable(req.getParameter("id"))
                        .filter(s -> !s.isBlank())
                        .map(Integer::parseUnsignedInt)
                        .orElseThrow(),
                req.getPart("image")
        );
    }

    default RemoveProductImageDTO toRemoveProductImageDTO(HttpServletRequest req) {
        return new RemoveProductImageDTO(
                Optional.ofNullable(req.getParameter("id"))
                        .filter(s -> !s.isBlank())
                        .map(Integer::parseUnsignedInt)
                        .orElseThrow(),
                Optional.ofNullable(req.getParameter("imageId"))
                        .filter(s -> !s.isBlank())
                        .map(Integer::parseUnsignedInt)
                        .orElseThrow()
        );
    }
}
