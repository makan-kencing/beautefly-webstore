package com.lavacorp.beautefly.webstore.rating.mapper;

import com.lavacorp.beautefly.webstore.account.mapper.AccountMapper;
import com.lavacorp.beautefly.webstore.file.mapper.FileUploadMapper;
import com.lavacorp.beautefly.webstore.rating.dto.RatingDTO;
import com.lavacorp.beautefly.webstore.rating.dto.RatingNewDTO;
import com.lavacorp.beautefly.webstore.rating.dto.ReplyNewDTO;
import com.lavacorp.beautefly.webstore.rating.entity.Rating;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

import java.io.IOException;

@Mapper(
        componentModel = MappingConstants.ComponentModel.CDI,
        uses = {AccountMapper.class, ReplyMapper.class, FileUploadMapper.class}
)
public interface RatingMapper {
    RatingDTO toRatingDTO(Rating rating);

    default RatingNewDTO toRatingNewDTO(HttpServletRequest req) throws ServletException, IOException {
        return new RatingNewDTO(
                Integer.parseUnsignedInt(req.getParameter("productId")),
                Integer.parseUnsignedInt(req.getParameter("rating")),
                req.getParameter("title"),
                req.getParameter("message"),
                req.getParts()
        );
    }

    default ReplyNewDTO toReplyNewDTO(HttpServletRequest req) {
        return new ReplyNewDTO(
                req.getParameter("message"),
                Integer.parseUnsignedInt(req.getParameter("originalId"))
        );
    }
}

