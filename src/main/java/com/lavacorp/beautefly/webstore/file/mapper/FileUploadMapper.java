package com.lavacorp.beautefly.webstore.file.mapper;

import com.lavacorp.beautefly.webstore.file.dto.FileUploadDTO;
import com.lavacorp.beautefly.webstore.file.entity.FileUpload;
import org.mapstruct.*;

@Mapper(componentModel = MappingConstants.ComponentModel.CDI)
public interface FileUploadMapper {
    FileUploadDTO toFileUploadDTO(FileUpload file);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "hash", ignore = true)
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    FileUpload updateMetadata(FileUpload src, @MappingTarget FileUpload dest);
}
