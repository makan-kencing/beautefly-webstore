package com.lavacorp.beautefly.webstore.account.entity;

import com.lavacorp.beautefly.webstore.file.entity.FileUpload;
import com.lavacorp.beautefly.webstore.file.entity.FileUpload_;
import com.lavacorp.beautefly.webstore.order.entity.SalesOrder;
import com.lavacorp.beautefly.webstore.order.entity.SalesOrder_;
import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Past;
import lombok.Getter;
import lombok.Setter;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.NamedQueries;
import org.hibernate.annotations.NamedQuery;

import java.io.Serializable;
import java.time.Duration;
import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;

import static jakarta.persistence.FetchType.EAGER;
import static jakarta.persistence.FetchType.LAZY;

@Getter
@Setter
@Entity
@NamedQueries({
        @NamedQuery(name = "UserAccount.findByEmail", query = "from UserAccount where email = :email"),
        @NamedQuery(name = "UserAccount.findByUsername", query = "from UserAccount where username = :username"),
        @NamedQuery(name = "UserAccount.findByUsernameLike", query = "from UserAccount where username ilike concat('%', :username, '%')"),
})
public class UserAccount extends Account implements Serializable {
    @NotBlank
    private String username;

    @NotNull
    @Email
    @Column(unique = true)
    private String email;

    @Enumerated(EnumType.STRING)
    private Gender gender = Gender.PREFER_NOT_TO_SAY;

    @Past
    private LocalDate dob;

    @OneToOne(fetch = EAGER)
    private FileUpload profileImage;

    @Embedded
    private Credential credential = new Credential();

    @Embedded
    private AddressBook addressBook = new AddressBook();

    @OneToMany(mappedBy = SalesOrder_.ACCOUNT, fetch = LAZY)
    private Set<SalesOrder> orders = new HashSet<>();

    @OneToMany(mappedBy = FileUpload_.CREATED_BY, fetch = LAZY)
    private Set<FileUpload> uploadedFiles = new HashSet<>();

    @ColumnDefault("true")
    private boolean active;

    public int getAge() {
        return (int) (Duration.between(LocalDate.now(), dob).toDays() / 365);
    }

    public enum Gender {
        MALE, FEMALE, PREFER_NOT_TO_SAY;

        public String pretty() {
            return StringUtils.capitalize(
                    name().replace('_', ' ')
            );
        }
    }
}
