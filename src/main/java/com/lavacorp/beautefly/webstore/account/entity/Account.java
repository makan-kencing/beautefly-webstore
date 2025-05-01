package com.lavacorp.beautefly.webstore.account.entity;

import com.lavacorp.beautefly.webstore.cart.entity.Cart;
import com.lavacorp.beautefly.webstore.cart.entity.Cart_;
import com.lavacorp.beautefly.webstore.cart.entity.Wishlist;
import com.lavacorp.beautefly.webstore.cart.entity.Wishlist_;
import com.lavacorp.beautefly.webstore.common.entity.UserCreated;
import com.lavacorp.beautefly.webstore.file.entity.FileUpload;
import com.lavacorp.beautefly.webstore.file.entity.FileUpload_;
import com.lavacorp.beautefly.webstore.order.entity.SalesOrder;
import com.lavacorp.beautefly.webstore.order.entity.SalesOrder_;
import com.lavacorp.beautefly.webstore.rating.entity.Rating;
import com.lavacorp.beautefly.webstore.rating.entity.Rating_;
import com.lavacorp.beautefly.webstore.rating.entity.Reply;
import com.lavacorp.beautefly.webstore.rating.entity.Reply_;
import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Past;
import lombok.Getter;
import lombok.Setter;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.annotations.NamedQueries;
import org.hibernate.annotations.NamedQuery;
import org.hibernate.annotations.NaturalId;

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
        @NamedQuery(name = "Account.findByEmail", query = "from Account where email = :email"),
        @NamedQuery(name = "Account.findByUsername", query = "from Account where username = :username"),
        @NamedQuery(name = "Account.findByUsernameLike", query = "from Account where username ilike concat('%', :username, '%')"),
})
public class Account extends UserCreated {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @NotNull
    @NotBlank
    private String username;

    @NotNull
    @Email
    @NaturalId(mutable = true)
    private String email;

    @OneToOne(fetch = EAGER)
    private FileUpload profileImage;

    @Enumerated(EnumType.STRING)
    private Gender gender = Gender.PREFER_NOT_TO_SAY;

    @Past
    private LocalDate dob;

    @Embedded
    private Credential credential = new Credential();

    @Embedded
    private AddressBook addressBook = new AddressBook();

    @OneToOne(mappedBy = Cart_.ACCOUNT, cascade = CascadeType.ALL)
    private Cart cart;

    @OneToOne(mappedBy = Wishlist_.ACCOUNT, cascade = CascadeType.ALL)
    private Wishlist wishlist;

    @OneToMany(mappedBy = SalesOrder_.ACCOUNT, fetch = LAZY, cascade = CascadeType.ALL)
    private Set<SalesOrder> orders = new HashSet<>();

    @OneToMany(mappedBy = FileUpload_.CREATED_BY, fetch = LAZY, cascade = CascadeType.ALL)
    private Set<FileUpload> uploadedFiles = new HashSet<>();

    @OneToMany(mappedBy = Rating_.ACCOUNT, fetch = LAZY)
    private Set<Rating> ratings = new HashSet<>();

    @OneToMany(mappedBy = Reply_.ACCOUNT, fetch = LAZY)
    private Set<Reply> replies = new HashSet<>();

    private boolean active = true;

    public int getAge() {
        return (int) (Duration.between(LocalDate.now(), dob).toDays() / 365);
    }

    public enum Gender {
        MALE, FEMALE, PREFER_NOT_TO_SAY;

        public String pretty() {
            return StringUtils.capitalize(
                    name().replace('_', ' ').toLowerCase()
            );
        }
    }
}
