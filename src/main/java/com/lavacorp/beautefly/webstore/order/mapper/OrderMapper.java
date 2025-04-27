package com.lavacorp.beautefly.webstore.order.mapper;

import com.lavacorp.beautefly.webstore.account.mapper.AccountMapper;
import com.lavacorp.beautefly.webstore.account.mapper.AddressMapper;
import com.lavacorp.beautefly.webstore.order.dto.OrderDetailsDTO;
import com.lavacorp.beautefly.webstore.order.dto.OrderItemDTO;
import com.lavacorp.beautefly.webstore.order.dto.OrderListingItemDTO;
import com.lavacorp.beautefly.webstore.order.dto.OrderListingDTO;
import com.lavacorp.beautefly.webstore.order.entity.SalesOrder;
import com.lavacorp.beautefly.webstore.order.entity.SalesOrderProduct;
import com.lavacorp.beautefly.webstore.product.mapper.ProductMapper;
import org.mapstruct.*;

@Mapper(
        componentModel = MappingConstants.ComponentModel.CDI,
        uses = {AddressMapper.class, ProductMapper.class, AccountMapper.class}
)
public interface OrderMapper {
    OrderDetailsDTO toOrderDetailsDTO(SalesOrder order);

    OrderItemDTO toOrderItemDTO(SalesOrderProduct orderProduct);

    OrderListingDTO toOrderListingDTO(SalesOrder order);

    OrderListingItemDTO toOrderListingItemDTO(SalesOrderProduct orderProduct);
}