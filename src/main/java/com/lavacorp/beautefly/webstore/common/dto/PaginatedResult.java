package com.lavacorp.beautefly.webstore.common.dto;

import jakarta.data.page.Page;
import org.jetbrains.annotations.NotNull;

import java.util.Iterator;
import java.util.List;

public record PaginatedResult<K>(
        List<K> content,
        int page,
        int pageSize,
        int maxPage,
        int total
) implements Iterable<K> {
    @Override
    public @NotNull Iterator<K> iterator() {
        return content.iterator();
    }

    public static <T> PaginatedResult<T> fromPaginated(Page<T> page) {
        return new PaginatedResult<T>(
                page.content(),
                (int) page.pageRequest().page(),
                page.pageRequest().size(),
                (int) page.totalPages(),
                (int) page.totalElements()
        );
    }

    public boolean hasNext() {
        return content.size() == pageSize && (total < 0 || total > pageSize * page);
    }

    public boolean hasPrevious() {
        return page > 1;
    }
}
