package com.lavacorp.beautefly.webstore.product.mapper;

import com.lavacorp.beautefly.webstore.order.dto.OrderHistoryProductDTO;
import com.lavacorp.beautefly.webstore.product.dto.ProductPageDTO;
import com.lavacorp.beautefly.webstore.product.entity.Product;
import com.lavacorp.beautefly.webstore.rating.mapper.RatingMapper;
import com.lavacorp.beautefly.webstore.search.dto.ProductSearchResultDTO;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

@Mapper(
        componentModel = MappingConstants.ComponentModel.CDI,
        uses = {CategoryMapper.class, ColorMapper.class, RatingMapper.class}
)
public interface ProductMapper {
    ProductSearchResultDTO fromProduct(Product product);

    ProductPageDTO toProductPageDTO(Product product);

    OrderHistoryProductDTO toOrderHistoryProductDTO(Product product);
}
