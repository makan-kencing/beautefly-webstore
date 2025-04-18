package com.lavacorp.beautefly.webstore.account.mapper;

import com.lavacorp.beautefly.webstore.account.dto.AddressDTO;
import com.lavacorp.beautefly.webstore.account.entity.Address;
import org.mapstruct.*;

@Mapper(componentModel = MappingConstants.ComponentModel.CDI)
public interface AddressMapper {
    @Mapping(target = "account", source = "")
    Address toAddress(AddressDTO addressDTO);

    AddressDTO toAddressDTO(Address address);

    @Mapping(target = "account", source = "")
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    Address partialUpdate(AddressDTO addressDTO, @MappingTarget Address address);
}