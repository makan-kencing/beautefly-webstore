package com.lavacorp.beautefly.webstore.account.mapper;

import com.lavacorp.beautefly.webstore.account.dto.UpdateCredentialDTO;
import com.lavacorp.beautefly.webstore.account.dto.UpdateUserAccountDTO;
import com.lavacorp.beautefly.webstore.account.dto.UserAccountDetailsDTO;
import com.lavacorp.beautefly.webstore.account.entity.UserAccount;
import com.lavacorp.beautefly.webstore.admin.dto.AdminContextDTO;
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
    RatingUserDTO toRatingUserDTO(UserAccount account);

    UserAccountDetailsDTO toUserAccountDetailsDTO(UserAccount account);

    @Mapping(target = "roles", source = "credential.roles")
    UserAccountSummaryDTO toUserAccountSummaryDTO(UserAccount account);

    @Mapping(target = "addresses", source = "addressBook.addresses")
    @Mapping(target = "roles", source = "credential.roles")
    AdminUserAccountDTO toAdminUserAccountDTO(UserAccount userAccount);

    @Mapping(target = "profileImage", ignore = true)
    @Mapping(target = "wishlist", ignore = true)
    @Mapping(target = "uploadedFiles", ignore = true)
    @Mapping(target = "orders", ignore = true)
    @Mapping(target = "credential", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "cart", ignore = true)
    @Mapping(target = "addressBook", ignore = true)
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    UserAccount partialUpdate(UpdateUserAccountDTO updateUserAccountDTO, @MappingTarget UserAccount userAccount);

    @Mapping(target = "wishlist", ignore = true)
    @Mapping(target = "username", ignore = true)
    @Mapping(target = "uploadedFiles", ignore = true)
    @Mapping(target = "profileImage", ignore = true)
    @Mapping(target = "orders", ignore = true)
    @Mapping(target = "gender", ignore = true)
    @Mapping(target = "dob", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "cart", ignore = true)
    @Mapping(target = "addressBook", ignore = true)
    @Mapping(target = "active", ignore = true)
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    @Mapping(source = "credentialPassword", target = "credential.password")
    UserAccount partialUpdateCredential(UpdateCredentialDTO updateCredentialDTO, @MappingTarget UserAccount userAccount);

    @Mapping(target = "roles", source = "credential.roles")
    AdminContextDTO toAdminContextDTO(UserAccount userAccount);
}
