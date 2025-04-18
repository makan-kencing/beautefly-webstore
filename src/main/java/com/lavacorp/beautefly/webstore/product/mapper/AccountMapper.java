package com.lavacorp.beautefly.webstore.product.mapper;

import com.lavacorp.beautefly.webstore.account.dto.UpdateCredentialDTO;
import com.lavacorp.beautefly.webstore.account.dto.UpdateUserAccountDTO;
import com.lavacorp.beautefly.webstore.account.dto.UserAccountDTO;
import com.lavacorp.beautefly.webstore.account.entity.UserAccount;
import com.lavacorp.beautefly.webstore.admin.dto.AdminUserAccountDTO;
import com.lavacorp.beautefly.webstore.admin.dto.UserAccountSummaryDTO;
import com.lavacorp.beautefly.webstore.file.mapper.FileMapper;
import com.lavacorp.beautefly.webstore.product.dto.RatingUserDTO;
import org.mapstruct.*;

@Mapper(
        componentModel = MappingConstants.ComponentModel.CDI,
        uses = {FileMapper.class}
)
public interface AccountMapper {
    RatingUserDTO toRatingUserDTO(UserAccount account);

    @Mapping(target = "addresses", source = "addressBook.addresses")
    UserAccountDTO toUserAccountDTO(UserAccount account);

    @Mapping(target = "roles", source = "credential.roles")
    UserAccountSummaryDTO toUserAccountSummaryDTO(UserAccount account);

    @Mapping(target = "addresses", source = "addressBook.addresses")
    @Mapping(target = "roles", expression = "credentials.roles")
    AdminUserAccountDTO toAdminUserAccountDTO(UserAccount userAccount);

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
}
