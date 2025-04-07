package com.lavacorp.beautefly.webstore.account.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.NamedQueries;
import org.hibernate.annotations.NamedQuery;
import org.hibernate.annotations.NaturalId;

import java.io.Serializable;

@Getter
@Setter
@Entity
@NamedQueries({
        @NamedQuery(name = "GuestAccount.findBySessionId", query = "from GuestAccount where sessionId = :sessionId")
})
public class GuestAccount extends Account implements Serializable {
    @NotBlank
    @Column(unique = true)
    private String sessionId;
}
