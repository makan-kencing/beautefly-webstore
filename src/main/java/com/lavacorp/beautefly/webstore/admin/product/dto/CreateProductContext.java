package com.lavacorp.beautefly.webstore.admin.product.dto;

import com.lavacorp.beautefly.webstore.product.dto.CategoryParentDTO;
import com.lavacorp.beautefly.webstore.product.dto.ColorDTO;

import java.util.List;

public record CreateProductContext(
        List<CategoryParentDTO> availableCategories,
        List<ColorDTO> availableColor,
        List<String> existingBrands
) {
}
