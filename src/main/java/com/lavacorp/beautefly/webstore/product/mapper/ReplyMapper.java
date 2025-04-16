package com.lavacorp.beautefly.webstore.product.mapper;

import com.lavacorp.beautefly.webstore.product.dto.ReplyDTO;
import com.lavacorp.beautefly.webstore.rating.entity.Reply;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

@Mapper(componentModel = MappingConstants.ComponentModel.CDI)
public interface ReplyMapper {
    ReplyDTO toReplyDTO(Reply reply);
}
