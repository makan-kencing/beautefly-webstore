package com.lavacorp.beautefly.webstore.search.mapper;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.wnameless.json.unflattener.JsonUnflattener;
import com.lavacorp.beautefly.webstore.account.entity.Account_;
import com.lavacorp.beautefly.webstore.account.entity.Credential;
import com.lavacorp.beautefly.webstore.account.entity.Credential_;
import com.lavacorp.beautefly.webstore.common.dto.Range;
import com.lavacorp.beautefly.webstore.product.entity.Product_;
import com.lavacorp.beautefly.webstore.search.dto.AccountSearchParametersDTO;
import com.lavacorp.beautefly.webstore.search.dto.DataTablesParameters;
import com.lavacorp.beautefly.webstore.search.dto.Direction;
import com.lavacorp.beautefly.webstore.search.dto.ProductSearchParametersDTO;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.chrono.ChronoLocalDate;
import java.util.*;

@Mapper(componentModel = MappingConstants.ComponentModel.CDI)
public interface SearchMapper {
    int DEFAULT_PAGE = 1;
    int DEFAULT_PAGE_SIZE = 50;
    ObjectMapper objectMapper = new ObjectMapper();

    default DataTablesParameters toDataTablesParameters(Map<String, List<String>> params) {
        Map<String, String> singleValueMap = new HashMap<>();
        for (var entry : params.entrySet())
            singleValueMap.put(entry.getKey(), entry.getValue().get(0));

        var unflattenMap = JsonUnflattener.unflattenAsMap(singleValueMap);
        return objectMapper.convertValue(unflattenMap, DataTablesParameters.class);
    }

    default AccountSearchParametersDTO toAccountSearchParameters(DataTablesParameters query) {
        String username = null;
        String email = null;
        List<Credential.Role> roles = null;
        Boolean active = null;
        List<AccountSearchParametersDTO.Sorter> sorts = null;

        for (var column : query.columns()) {
            var value = column.search().value();
            if (!value.isBlank())
                switch (column.name()) {
                    case Account_.USERNAME -> username = value;
                    case Account_.EMAIL -> email = value;
                    case Credential_.ROLES -> roles = Arrays.stream(value.split(","))
                            .map(Credential.Role::valueOf)
                            .toList();
                    case Account_.ACTIVE -> active = Account_.ACTIVE.equals(value);
                }
        }

        if (query.order() != null)
            sorts = query.order().stream()
                    .map(order -> {
                        try {
                            var attribute = AccountSearchParametersDTO.Sorter.Attribute
                                    .valueOf(order.name());
                            return new AccountSearchParametersDTO.Sorter(attribute, order.dir());
                        } catch (IllegalArgumentException ignored) {
                            return null;
                        }
                    }).filter(Objects::nonNull)
                    .toList();

        return new AccountSearchParametersDTO(
                query.search().value(),
                username,
                email,
                roles,
                active,
                query.start() / query.length() + 1,
                query.length(),
                sorts
        );
    }

    default ProductSearchParametersDTO toProductSearchParameters(DataTablesParameters query) {
        String name = null;
        List<String> categories = null;
        List<String> brands = null;
        Range<BigDecimal> priceRange = null;
        Range<ChronoLocalDate> releaseRange = null;
        List<String> colors = null;
        List<ProductSearchParametersDTO.Sorter> sorts = null;

        for (var column : query.columns()) {
            var value = column.search().value();
            if (!value.isBlank())
                switch (column.name()) {
                    case Product_.NAME -> name = column.search().value();
                    case Product_.CATEGORY -> categories = Arrays.stream(value.split(",")).toList();
                    case Product_.BRAND -> brands = Arrays.stream(value.split(",")).toList();
                    case Product_.COLOR -> colors = Arrays.stream(value.split(",")).toList();
                }
        }

        if (query.order() != null)
            sorts = query.order().stream()
                    .map(order -> {
                        try {
                            var attribute = ProductSearchParametersDTO.Sorter.Attribute
                                    .valueOf(order.name());
                            return new ProductSearchParametersDTO.Sorter(attribute, order.dir());
                        } catch (IllegalArgumentException ignored) {
                            return null;
                        }
                    }).filter(Objects::nonNull)
                    .toList();

        // TODO: priceRange + releaseRange

        return new ProductSearchParametersDTO(
                query.search().value(),
                name,
                categories,
                brands,
                priceRange,
                releaseRange,
                colors,
                query.start() / query.length() + 1,
                query.length(),
                sorts
        );
    }

    default ProductSearchParametersDTO toProductSearchParameters(Map<String, String[]> params) {
        String query = Optional.ofNullable(params.get("query"))
                .map(s -> s[0])
                .orElse(null);

        String name = Optional.ofNullable(params.get("name"))
                .map(s -> s[0])
                .orElse(null);

        List<String> categories = Optional.ofNullable(params.get("categories"))
                .map(s -> Arrays.stream(s).toList())
                .orElse(null);

        List<String> brands = Optional.ofNullable(params.get("brands"))
                .map(s -> Arrays.stream(s).toList())
                .orElse(null);

        List<String> colors = Optional.ofNullable(params.get("colors"))
                .map(s -> Arrays.stream(s).toList())
                .orElse(null);

        BigDecimal priceLow = Optional.ofNullable(params.get("price_low"))
                .map(s -> s[0])
                .map(BigDecimal::new)
                .orElse(null);
        BigDecimal priceHigh = Optional.ofNullable(params.get("price_high"))
                .map(s -> s[0])
                .map(BigDecimal::new)
                .orElse(null);
        Range<BigDecimal> price = priceLow != null && priceHigh != null
                ? new Range<>(priceLow, priceHigh)
                : null;

        LocalDate lastRelease = Optional.ofNullable(params.get("releaseData_low"))
                .map(s -> s[0])
                .map(LocalDate::parse)
                .orElse(null);
        LocalDate newestRelease = Optional.ofNullable(params.get("releaseDate_high"))
                .map(s -> s[0])
                .map(LocalDate::parse)
                .orElse(null);
        Range<ChronoLocalDate> releaseRange = lastRelease != null && newestRelease != null
                ? new Range<>(lastRelease, newestRelease)
                : null;

        int page = Optional.ofNullable(params.get("page"))
                .map(s -> s[0])
                .map(Integer::parseUnsignedInt)
                .orElse(DEFAULT_PAGE);

        int pageSize = Optional.ofNullable(params.get("pageSize"))
                .map(s -> s[0])
                .map(Integer::parseUnsignedInt)
                .orElse(DEFAULT_PAGE_SIZE);

        // TODO: make work with multiple sorts
        var attribute = Optional.ofNullable(params.get("sort"))
                .map(s -> s[0])
                .map(ProductSearchParametersDTO.Sorter.Attribute::valueOf)
                .orElse(null);
        var direction = Optional.ofNullable(params.get("direction"))
                .map(s -> s[0])
                .map(Direction::valueOf)
                .orElse(null);
        var sorts = attribute != null && direction != null
                ? List.of(new ProductSearchParametersDTO.Sorter(attribute, direction))
                : null;

        return new ProductSearchParametersDTO(
                query,
                name,
                categories,
                brands,
                price,
                releaseRange,
                colors,
                page,
                pageSize,
                sorts
        );
    }
}
