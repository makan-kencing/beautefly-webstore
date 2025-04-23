package com.lavacorp.beautefly.webstore.search.mapper;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.wnameless.json.unflattener.JsonUnflattener;
import com.lavacorp.beautefly.webstore.search.dto.AccountSearchParametersDTO;
import com.lavacorp.beautefly.webstore.search.dto.DataTablesParameters;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Mapper(componentModel = MappingConstants.ComponentModel.CDI)
public interface SearchMapper {
    ObjectMapper objectMapper = new ObjectMapper();

    default DataTablesParameters toDataTablesParameters(Map<String, List<String>> params) {
        Map<String, String> singleValueMap = new HashMap<>();
        for (var entry : params.entrySet())
            singleValueMap.put(entry.getKey(), entry.getValue().get(0));

        var unflattenMap = JsonUnflattener.unflattenAsMap(singleValueMap);
        return objectMapper.convertValue(unflattenMap, DataTablesParameters.class);
    }

    default AccountSearchParametersDTO toAccountSearchParameters(DataTablesParameters params) {

    }
}
