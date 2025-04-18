package com.lavacorp.beautefly.webstore.file.mapper;

import com.lavacorp.beautefly.webstore.file.dto.UseFileDTO;
import com.lavacorp.beautefly.webstore.file.entity.File;
import com.lavacorp.beautefly.webstore.file.dto.FileDTO;
import org.mapstruct.*;

@Mapper(componentModel = MappingConstants.ComponentModel.CDI)
public interface FileMapper {
    FileDTO toFileDto(File file);

    UseFileDTO toUseFileDto(File file);

    @Mapping(target = "promotion", ignore = true)
    @Mapping(target = "product", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "account", ignore = true)
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    File partialUpdate(FileDTO fileDTO, @MappingTarget File file);
}
