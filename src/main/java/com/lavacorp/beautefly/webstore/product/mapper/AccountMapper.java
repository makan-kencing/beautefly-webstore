package com.lavacorp.beautefly.webstore.product.mapper;

import com.lavacorp.beautefly.webstore.account.dto.UpdateCredentialDTO;
import com.lavacorp.beautefly.webstore.account.dto.UpdateUserAccountDTO;
import com.lavacorp.beautefly.webstore.account.dto.UserAccountDTO;
import com.lavacorp.beautefly.webstore.account.entity.UserAccount;
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

    @Mapping(target = "wishlist", source = "")
    @Mapping(target = "uploadedFiles", source = "")
    @Mapping(target = "orders", source = "")
    @Mapping(target = "credential", source = "")
    @Mapping(target = "createdAt", source = "")
    @Mapping(target = "cart", source = "")
    @Mapping(target = "addressBook", source = "")
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    UserAccount partialUpdate(UpdateUserAccountDTO updateUserAccountDTO, @MappingTarget UserAccount userAccount);

    @Mapping(target = "wishlist", source = "")
    @Mapping(target = "username", source = "")
    @Mapping(target = "uploadedFiles", source = "")
    @Mapping(target = "profileImage", source = "")
    @Mapping(target = "orders", source = "")
    @Mapping(target = "gender", source = "")
    @Mapping(target = "dob", source = "")
    @Mapping(target = "createdAt", source = "")
    @Mapping(target = "cart", source = "")
    @Mapping(target = "addressBook", source = "")
    @Mapping(target = "active", source = "")
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    @Mapping(source = "credentialPassword", target = "credential.password")
    UserAccount partialUpdateCredential(UpdateCredentialDTO updateCredentialDTO, @MappingTarget UserAccount userAccount);
}
