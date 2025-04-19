package com.lavacorp.beautefly.webstore.file.mapper;

import com.lavacorp.beautefly.webstore.file.entity.FileUpload;
import com.lavacorp.beautefly.webstore.file.dto.FileDTO;
import org.mapstruct.*;

import java.net.URI;

@Mapper(componentModel = MappingConstants.ComponentModel.CDI)
public interface FileUploadMapper {
    FileDTO toFileUploadDTO(FileUpload file, URI href);

    @Mapping(target = "promotion", ignore = true)
    @Mapping(target = "product", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "account", ignore = true)
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    FileUpload partialUpdate(FileDTO fileDTO, @MappingTarget FileUpload file);
}
