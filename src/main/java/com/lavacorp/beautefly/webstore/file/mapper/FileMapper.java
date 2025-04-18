package com.lavacorp.beautefly.webstore.file.mapper;

import com.lavacorp.beautefly.webstore.file.dto.UseFileDTO;
import com.lavacorp.beautefly.webstore.file.entity.File;
import com.lavacorp.beautefly.webstore.file.dto.FileDTO;
import org.mapstruct.*;

@Mapper(componentModel = MappingConstants.ComponentModel.CDI)
public interface FileMapper {
    FileDTO toFileDto(File file);

    UseFileDTO toUseFileDto(File file);

    File toEntity(UseFileDTO useFileDTO);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    File partialUpdate(UseFileDTO useFileDTO, @MappingTarget File file);
}
