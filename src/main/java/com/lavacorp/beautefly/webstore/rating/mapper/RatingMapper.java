package com.lavacorp.beautefly.webstore.rating.mapper;

import com.lavacorp.beautefly.webstore.rating.dto.RatingDTO;
import com.lavacorp.beautefly.webstore.account.mapper.AccountMapper;
import com.lavacorp.beautefly.webstore.rating.entity.Rating;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

@Mapper(
        componentModel = MappingConstants.ComponentModel.CDI,
        uses = {AccountMapper.class, ReplyMapper.class}
)
public interface RatingMapper {
    RatingDTO toRatingDTO(Rating rating);
}

