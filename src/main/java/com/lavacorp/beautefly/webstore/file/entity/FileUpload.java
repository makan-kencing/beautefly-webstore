package com.lavacorp.beautefly.webstore.file.entity;

import com.lavacorp.beautefly.webstore.account.entity.UserAccount;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.apache.tika.mime.MimeType;
import org.hibernate.Length;
import org.hibernate.annotations.CurrentTimestamp;
import org.hibernate.annotations.NaturalId;

import java.net.URI;
import java.time.Instant;

@Getter
@Setter
@Entity
public class FileUpload {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @NotNull
    @NotBlank
    @NaturalId
    private String hash;

    @NotNull
    @NotBlank
    private String filename;

    @NotNull
    @Column(length = Length.LONG)
    private URI url;

    @NotNull
    private MimeType type;

    @CurrentTimestamp
    private Instant createdAt;

    @ManyToOne(fetch = FetchType.LAZY)
    private UserAccount createdBy;
}
