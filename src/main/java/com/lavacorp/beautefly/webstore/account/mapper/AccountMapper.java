package com.lavacorp.beautefly.webstore.account.mapper;

import com.lavacorp.beautefly.webstore.account.dto.UpdateUserAccountDetailsDTO;
import com.lavacorp.beautefly.webstore.account.dto.UserAccountDetailsDTO;
import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.admin.dto.AdminUserAccountDTO;
import com.lavacorp.beautefly.webstore.admin.dto.UserAccountSummaryDTO;
import com.lavacorp.beautefly.webstore.file.mapper.FileUploadMapper;
import com.lavacorp.beautefly.webstore.rating.dto.RatingUserDTO;
import com.lavacorp.beautefly.webstore.search.dto.AccountSearchResultDTO;
import com.lavacorp.beautefly.webstore.security.dto.AccountContextDTO;
import jakarta.servlet.http.HttpServletRequest;
import org.mapstruct.*;

import java.time.LocalDate;
import java.util.Optional;

@Mapper(
        componentModel = MappingConstants.ComponentModel.CDI,
        uses = {FileUploadMapper.class}
)
public interface AccountMapper {
    RatingUserDTO toRatingUserDTO(Account account);

    @Mapping(target = "roles", source = "credential.roles")
    UserAccountDetailsDTO toUserAccountDetailsDTO(Account account);

    @Mapping(target = "roles", source = "credential.roles")
    UserAccountSummaryDTO toUserAccountSummaryDTO(Account account);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "active", ignore = true)
    @Mapping(target = "replies", ignore = true)
    @Mapping(target = "ratings", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    @Mapping(target = "createdBy", ignore = true)
    @Mapping(target = "profileImage", ignore = true)
    @Mapping(target = "wishlist", ignore = true)
    @Mapping(target = "uploadedFiles", ignore = true)
    @Mapping(target = "orders", ignore = true)
    @Mapping(target = "credential", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "cart", ignore = true)
    @Mapping(target = "addressBook", ignore = true)
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    Account partialUpdate(UpdateUserAccountDetailsDTO updateUserAccountDetailsDTO, @MappingTarget Account account);

    @Mapping(target = "roles", source = "credential.roles")
    AccountContextDTO toAccountContextDTO(Account account);

    @Mapping(target = "roles", source = "credential.roles")
    AccountSearchResultDTO toAccountSearchResultDTO(Account account);

    @Mapping(target = "roles", source = "credential.roles")
    @Mapping(target = "profileImageHash", source = "profileImage.hash")
    AdminUserAccountDTO toAdminUserAccountDTO(Account account);

    default UpdateUserAccountDetailsDTO fromRequest(HttpServletRequest req) {
        return new UpdateUserAccountDetailsDTO(
                req.getParameter("username"),
                req.getParameter("email"),
                Optional.of(req.getParameter("gender"))
                        .filter(s -> !s.isBlank())
                        .map(Account.Gender::valueOf)
                        .orElse(Account.Gender.PREFER_NOT_TO_SAY),
                Optional.of(req.getParameter("dob"))
                        .filter(s -> !s.isBlank())
                        .map(LocalDate::parse)
                        .orElse(null)
        );
    }
}
