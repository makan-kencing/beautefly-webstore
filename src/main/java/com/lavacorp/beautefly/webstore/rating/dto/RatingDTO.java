package com.lavacorp.beautefly.webstore.rating.dto;

import com.lavacorp.beautefly.webstore.file.dto.FileDTO;

import java.io.Serializable;
import java.time.Instant;
import java.util.List;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.rating.entity.Rating}
 */
public record RatingDTO(
        int id,
        RatingUserDTO account,
        int rating,
        String message,
        List<FileDTO> images,
        Instant ratedOn,
        List<ReplyDTO> replies
) implements Serializable {
}