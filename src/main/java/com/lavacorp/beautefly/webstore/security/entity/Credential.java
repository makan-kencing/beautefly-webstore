package com.lavacorp.beautefly.webstore.security.entity;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

import java.util.Set;
import java.util.stream.Collectors;

@Data
@Entity
public class Credential {
    @Id
    private int id;

    @OneToOne(optional = false)
    @MapsId
    private Account account;

    @NotBlank
    private String password;

    @ElementCollection(fetch = FetchType.EAGER)
    @Enumerated(EnumType.STRING)
    private Set<Role> roles = Set.of(
            Role.USER
    );

    public Set<String> getRolesAsString() {
        return roles.stream()
                .map(Enum::name)
                .collect(Collectors.toSet());
    }

    public enum Role {
        USER, ADMIN, STAFF
    }
}
