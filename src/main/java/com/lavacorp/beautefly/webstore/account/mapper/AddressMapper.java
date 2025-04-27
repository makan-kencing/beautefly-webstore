package com.lavacorp.beautefly.webstore.account.mapper;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.lavacorp.beautefly.webstore.account.dto.AddressDTO;
import com.lavacorp.beautefly.webstore.account.dto.AddressesDTO;
import com.lavacorp.beautefly.webstore.account.entity.Address;
import com.lavacorp.beautefly.webstore.account.entity.AddressBook;
import org.mapstruct.*;

import java.util.HashMap;
import java.util.Map;

@Mapper(componentModel = MappingConstants.ComponentModel.CDI)
public interface AddressMapper {
    ObjectMapper objectMapper = new ObjectMapper();

    @Mapping(target = "account", ignore = true)
    Address toAddress(AddressDTO addressDTO);

    AddressDTO toAddressDTO(Address address);

    @Mapping(target = "account", ignore = true)
    @Mapping(target = "id", ignore = true)
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    Address partialUpdate(AddressDTO addressDTO, @MappingTarget Address address);

    @Mapping(target = "defaultAddressId", source = "defaultAddress.id")
    AddressesDTO toAddressesDTO(AddressBook addressBook);

    default AddressDTO toAddressDTO(Map<String, String[]> params) {
        Map<String, String> singleValueMap = new HashMap<>();
        for (var entry : params.entrySet())
            singleValueMap.put(entry.getKey(), entry.getValue()[0]);

        return objectMapper.convertValue(singleValueMap, AddressDTO.class);
    }
}