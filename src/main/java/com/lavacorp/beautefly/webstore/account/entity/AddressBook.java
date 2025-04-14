package com.lavacorp.beautefly.webstore.account.entity;

import jakarta.annotation.Nullable;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Embeddable;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import static jakarta.persistence.FetchType.LAZY;

@Getter
@Setter
@Embeddable
public class AddressBook implements Serializable {
    @OneToMany(mappedBy = Address_.ACCOUNT, fetch = LAZY)
    private Set<Address> addresses = new HashSet<>();

    @Nullable
    @OneToOne(fetch = LAZY, cascade = CascadeType.ALL)
    private Address defaultAddress;
}
