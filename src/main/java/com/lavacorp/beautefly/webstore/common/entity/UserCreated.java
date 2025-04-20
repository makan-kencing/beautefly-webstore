package com.lavacorp.beautefly.webstore.common.entity;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import jakarta.persistence.FetchType;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MappedSuperclass;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@MappedSuperclass
public class UserCreated extends Auditable {
    @ManyToOne(fetch = FetchType.LAZY)
    protected Account createdBy;
}
