package com.lavacorp.beautefly.webstore.account.entity;

import jakarta.annotation.Nullable;
import jakarta.persistence.Embeddable;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import lombok.Getter;
import lombok.Setter;

import java.util.Set;

import static jakarta.persistence.FetchType.LAZY;

@Getter
@Setter
@Embeddable
public class AddressBook {
    @OneToMany(mappedBy = Address_.ACCOUNT, fetch = LAZY)
    private Set<Address> addresses;

    @Nullable
    @OneToOne(fetch = LAZY)
    private Address defaultAddress;
}
