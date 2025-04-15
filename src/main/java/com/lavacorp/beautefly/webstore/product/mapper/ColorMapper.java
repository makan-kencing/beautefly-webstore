package com.lavacorp.beautefly.webstore.product.mapper;

import com.lavacorp.beautefly.webstore.product.dto.ColorDTO;
import com.lavacorp.beautefly.webstore.product.entity.Color;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

@Mapper(componentModel = MappingConstants.ComponentModel.CDI)
public interface ColorMapper {
    ColorDTO fromColor(Color color);
}
