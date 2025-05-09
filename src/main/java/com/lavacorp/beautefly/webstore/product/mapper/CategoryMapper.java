package com.lavacorp.beautefly.webstore.product.mapper;

import com.lavacorp.beautefly.webstore.file.mapper.FileUploadMapper;
import com.lavacorp.beautefly.webstore.product.dto.CategoryDTO;
import com.lavacorp.beautefly.webstore.product.dto.CategoryTreeDTO;
import com.lavacorp.beautefly.webstore.product.entity.Category;
import org.mapstruct.*;

@Mapper(componentModel = MappingConstants.ComponentModel.CDI, uses = {FileUploadMapper.class})
public interface CategoryMapper {
    CategoryDTO toCategoryDTO(Category category);

    CategoryTreeDTO toCategoryTreeDTO(Category category);
}
