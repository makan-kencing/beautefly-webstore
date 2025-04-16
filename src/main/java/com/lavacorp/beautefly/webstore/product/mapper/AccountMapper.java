package com.lavacorp.beautefly.webstore.product.mapper;

import com.lavacorp.beautefly.webstore.account.entity.UserAccount;
import com.lavacorp.beautefly.webstore.product.dto.RatingUserDTO;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

@Mapper(
        componentModel = MappingConstants.ComponentModel.CDI,
        uses = {}
)
public interface AccountMapper {
    RatingUserDTO toRatingUserDTO(UserAccount user);
}
