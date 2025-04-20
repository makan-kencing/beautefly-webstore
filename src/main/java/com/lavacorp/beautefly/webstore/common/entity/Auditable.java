package com.lavacorp.beautefly.webstore.common.entity;

import jakarta.persistence.MappedSuperclass;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PastOrPresent;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CurrentTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.io.Serializable;
import java.time.Instant;

@Getter
@Setter
@MappedSuperclass
public class Auditable implements Serializable {
    @NotNull
    @PastOrPresent
    @CurrentTimestamp
    protected Instant createdAt;

    @NotNull
    @PastOrPresent
    @UpdateTimestamp
    protected Instant updatedAt;
}
