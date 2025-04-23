package com.lavacorp.beautefly.webstore.cart.mapper;

import com.lavacorp.beautefly.webstore.cart.dto.CartDTO;
import com.lavacorp.beautefly.webstore.cart.dto.CartItemDTO;
import com.lavacorp.beautefly.webstore.cart.dto.UpdateCartProductDTO;
import com.lavacorp.beautefly.webstore.cart.entity.Cart;
import com.lavacorp.beautefly.webstore.cart.entity.CartProduct;
import com.lavacorp.beautefly.webstore.product.mapper.ProductMapper;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingConstants;

import java.util.Map;
import java.util.Optional;

@Mapper(
        componentModel = MappingConstants.ComponentModel.CDI,
        uses = {ProductMapper.class}
)
public interface CartMapper {
    CartItemDTO toCartItemDTO(CartProduct cartItems);

    @Mapping(target = "id", source = "id")
    @Mapping(target = "total", source = "total")
    @Mapping(target = "subtotal", source = "subtotal")
    @Mapping(target = "shippingCost", source = "shippingCost")
    @Mapping(target = "isShippingDiscounted", source = "isShippingDiscounted")
    @Mapping(target = "estimatedTax", source = "estimatedTax")
    @Mapping(target = "items", source = "products")
    CartDTO toCartDTO(Cart cart);

    default UpdateCartProductDTO toUpdateCartProductDTO(Map<String, String[]> params, UpdateCartProductDTO.Action action) {
        return new UpdateCartProductDTO(
                Optional.ofNullable(params.get("productId"))
                        .map(vals -> Integer.parseUnsignedInt(vals[0]))
                        .orElseThrow(),
                Optional.ofNullable(params.get("quantity"))
                        .map(vals -> Integer.parseUnsignedInt(vals[0]))
                        .orElseThrow(),
                action
        );
    }
}
