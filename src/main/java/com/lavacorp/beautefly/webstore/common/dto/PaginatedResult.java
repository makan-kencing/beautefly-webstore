package com.lavacorp.beautefly.webstore.common.dto;

import jakarta.data.page.Page;
import org.jetbrains.annotations.NotNull;

import java.util.Iterator;
import java.util.List;

public record PaginatedResult<K>(
        List<K> data,
        int page,
        int pageSize,
        int maxPage,
        int filteredTotal,
        int total
) implements Iterable<K> {
    @Override
    public @NotNull Iterator<K> iterator() {
        return data.iterator();
    }

    public static <T> PaginatedResult<T> fromPaginated(Page<T> page, int total) {
        return new PaginatedResult<T>(
                page.content(),
                (int) page.pageRequest().page(),
                page.pageRequest().size(),
                (int) page.totalPages(),
                (int) page.totalElements(),
                total
        );
    }

    public boolean hasNext() {
        return data.size() == pageSize && (filteredTotal < 0 || filteredTotal > pageSize * page);
    }

    public boolean hasPrevious() {
        return page > 1;
    }
}
