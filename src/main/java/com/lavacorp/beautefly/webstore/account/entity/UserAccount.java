package com.lavacorp.beautefly.webstore.account.entity;

import com.lavacorp.beautefly.webstore.order.entity.SalesOrder;
import com.lavacorp.beautefly.webstore.order.entity.SalesOrder_;
import jakarta.persistence.Column;
import jakarta.persistence.Embedded;
import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Past;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.NamedQueries;
import org.hibernate.annotations.NamedQuery;
import org.hibernate.validator.constraints.URL;

import java.io.Serializable;
import java.time.Duration;
import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;

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

    private String firstName;
    private String lastName;
    private String phone;
    private String gender;

    @NotNull
    @Email
    @Column(unique = true)
    private String email;

    @Past
    private LocalDate dob;

    @URL
    private String profileImageUrl;

    @Embedded
    private Credential credential = new Credential();

    @Embedded
    private AddressBook addressBook = new AddressBook();

    @OneToMany(mappedBy = SalesOrder_.ACCOUNT, fetch = LAZY)
    private Set<SalesOrder> orders = new HashSet<>();

    @ColumnDefault("true")
    private boolean active;

    public int getAge() {
        return (int) (Duration.between(LocalDate.now(), dob).toDays() / 365);
    }
}
