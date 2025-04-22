package com.lavacorp.beautefly.webstore.account.mapper;

import com.lavacorp.beautefly.webstore.account.dto.UpdateUserAccountDTO;
import com.lavacorp.beautefly.webstore.account.dto.UserAccountDetailsDTO;
import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.security.dto.AccountContextDTO;
import com.lavacorp.beautefly.webstore.admin.dto.AdminUserAccountDTO;
import com.lavacorp.beautefly.webstore.admin.dto.UserAccountSummaryDTO;
import com.lavacorp.beautefly.webstore.file.mapper.FileUploadMapper;
import com.lavacorp.beautefly.webstore.rating.dto.RatingUserDTO;
import org.mapstruct.*;

@Mapper(
        componentModel = MappingConstants.ComponentModel.CDI,
        uses = {FileUploadMapper.class}
)
public interface AccountMapper {
    RatingUserDTO toRatingUserDTO(Account account);

    UserAccountDetailsDTO toUserAccountDetailsDTO(Account account);

    @Mapping(target = "roles", source = "credential.roles")
    UserAccountSummaryDTO toUserAccountSummaryDTO(Account account);

    @Mapping(target = "addresses", source = "addressBook.addresses")
    @Mapping(target = "roles", source = "credential.roles")
    AdminUserAccountDTO toAdminUserAccountDTO(Account account);

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
    Account partialUpdate(UpdateUserAccountDTO updateUserAccountDTO, @MappingTarget Account account);

    @Mapping(target = "roles", source = "credential.roles")
    AccountContextDTO toAccountContextDTO(Account account);
}
