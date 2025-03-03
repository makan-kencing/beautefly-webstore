package com.samseng.web.user.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.NaturalId;

@Data
@Entity
@Table(name = "\"User\"")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @NaturalId
    @NotBlank
    @Column(unique = true)
    private String username;

    @NaturalId
    @Email
    @Column(unique = true)
    private String email;

    @NotNull
    @Size(max = 60)
    private byte[] password;

    @Enumerated(EnumType.STRING)
    @ColumnDefault("USER")
    private Role role;

    public enum Role {
        USER, ADMIN, STAFF
    }
}
