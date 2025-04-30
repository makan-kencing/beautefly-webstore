package com.lavacorp.beautefly.webstore.admin.mapper;

import com.lavacorp.beautefly.webstore.admin.dto.DeleteAccountDTO;
import jakarta.servlet.http.HttpServletRequest;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Optional;

@Mapper(
        componentModel = MappingConstants.ComponentModel.CDI
)
public interface AdminAccountMapper {
    default DeleteAccountDTO toDeleteAccountDTO(HttpServletRequest req) {
        return new DeleteAccountDTO(
                Optional.ofNullable(req.getParameterValues("id"))
                        .map(s -> Arrays.stream(s)
                                .map(Integer::parseUnsignedInt)
                                .toList()
                        ).orElse(new ArrayList<>())
        );
    }
}
