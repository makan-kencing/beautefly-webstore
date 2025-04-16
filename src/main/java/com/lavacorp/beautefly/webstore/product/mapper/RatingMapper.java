package com.lavacorp.beautefly.webstore.product.mapper;

import com.lavacorp.beautefly.webstore.product.dto.RatingDTO;
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

