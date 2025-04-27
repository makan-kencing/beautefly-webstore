package com.lavacorp.beautefly.webstore.account.mapper;

import com.lavacorp.beautefly.webstore.account.dto.AddressDTO;
import com.lavacorp.beautefly.webstore.account.dto.AddressesDTO;
import com.lavacorp.beautefly.webstore.account.entity.Address;
import com.lavacorp.beautefly.webstore.account.entity.AddressBook;
import org.mapstruct.*;

@Mapper(componentModel = MappingConstants.ComponentModel.CDI)
public interface AddressMapper {
    @Mapping(target = "account", ignore = true)
    Address toAddress(AddressDTO addressDTO);

    AddressDTO toAddressDTO(Address address);

    @Mapping(target = "account", ignore = true)
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    Address partialUpdate(AddressDTO addressDTO, @MappingTarget Address address);

    @Mapping(target = "defaultAddressId", source = "defaultAddress.id")
    AddressesDTO toAddressesDTO(AddressBook addressBook);
}