package com.lavacorp.beautefly.webstore.account.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.Set;
import java.util.stream.Collectors;

import static jakarta.persistence.FetchType.EAGER;

@Getter
@Setter
@Embeddable
public class Credential implements Serializable {
    @NotBlank
    private String password;

    @ElementCollection(fetch = EAGER)
    @Enumerated(EnumType.STRING)
    private Set<Role> roles = Set.of(
            Role.USER
    );

    public Set<String> getRolesAsString() {
        return roles.stream()
                .map(Enum::name)
                .collect(Collectors.toSet());
    }

    @Getter
    @AllArgsConstructor
    public enum Role {
        USER,
        STAFF,
        ADMIN
    }
}
