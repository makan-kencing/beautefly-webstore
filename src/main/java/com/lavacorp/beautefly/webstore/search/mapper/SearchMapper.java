package com.lavacorp.beautefly.webstore.search.mapper;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.wnameless.json.unflattener.JsonUnflattener;
import com.lavacorp.beautefly.webstore.account.entity.Account_;
import com.lavacorp.beautefly.webstore.account.entity.Credential;
import com.lavacorp.beautefly.webstore.account.entity.Credential_;
import com.lavacorp.beautefly.webstore.search.dto.AccountSearchParametersDTO;
import com.lavacorp.beautefly.webstore.search.dto.DataTablesParameters;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

import java.util.*;

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

    default AccountSearchParametersDTO toAccountSearchParameters(DataTablesParameters query) {
        String username = null;
        String email = null;
        List<Credential.Role> roles = null;
        Boolean active = null;

        for (var column : query.columns())
            if (!column.search().value().isBlank())
                switch (column.data()) {
                    case Account_.USERNAME -> username = column.search().value();
                    case Account_.EMAIL -> email = column.search().value();
                    case Credential_.ROLES + "[, ]" -> roles = Arrays.stream(column.search().value().split(","))
                            .map(Credential.Role::valueOf)
                            .toList();
                    case Account_.ACTIVE -> active = Account_.ACTIVE.equals(column.search().value());
                }

        List<AccountSearchParametersDTO.Sorter> sort = null;

        if (query.order() != null)
            sort = query.order().stream()
                    .map(order -> {
                        try {
                            var attribute = AccountSearchParametersDTO.Sorter.Attribute
                                    .valueOf(order.name());
                            return new AccountSearchParametersDTO.Sorter(attribute, order.dir());
                        } catch (IllegalArgumentException ignored) {
                            return null;
                        }
                    }).filter(Objects::nonNull)
                    .toList();

        return new AccountSearchParametersDTO(
                query.search().value(),
                username,
                email,
                roles,
                active,
                query.start() / query.length() + 1,
                query.length(),
                sort
        );
    }
}
