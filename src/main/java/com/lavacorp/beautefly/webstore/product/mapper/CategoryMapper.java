package com.lavacorp.beautefly.webstore.product.mapper;

import com.lavacorp.beautefly.webstore.product.dto.CategoryDTO;
import com.lavacorp.beautefly.webstore.product.entity.Category;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

@Mapper(componentModel = MappingConstants.ComponentModel.CDI)
public interface CategoryMapper {
    CategoryDTO fromCategory(Category category);
}
