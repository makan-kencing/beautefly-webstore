package com.lavacorp.beautefly.webstore.rating.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.PastOrPresent;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CurrentTimestamp;

import java.io.Serializable;
import java.time.Instant;

@Getter
@Setter
@Entity
public class Reply implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    private Rating original;

    private String message;

    @CurrentTimestamp
    @PastOrPresent
    private Instant repliedOn;
}
