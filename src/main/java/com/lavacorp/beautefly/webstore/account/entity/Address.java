package com.lavacorp.beautefly.webstore.account.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

import java.io.Serializable;

@Data
@Entity
public class Address implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @NotBlank
    private String name;

    @NotBlank
    private String contactNo;

    @NotBlank
    private String address1;

    private String address2;

    private String address3;

    @NotBlank
    private String postcode;

    @NotBlank
    private String state;

    @NotBlank
    private String country;

    @ManyToOne
    private Account account;
}
