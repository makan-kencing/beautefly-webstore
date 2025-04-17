package com.lavacorp.beautefly.webstore.file.entity;

import com.lavacorp.beautefly.webstore.account.entity.UserAccount;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.apache.tika.mime.MediaType;
import org.hibernate.annotations.CurrentTimestamp;

import java.time.Instant;

@Getter
@Setter
@Entity
public class File {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @NotNull
    @NotBlank
    private String filename;

    @NotNull
    @Enumerated(EnumType.STRING)
    private FileType type;

    @CurrentTimestamp
    private Instant createdAt;

    @ManyToOne(fetch = FetchType.LAZY)
    private UserAccount account;

    public enum FileType {
        IMAGE;

        public static FileType fromMediaType(MediaType mediaType) {
            return switch (mediaType.getType()) {
                case "image" -> IMAGE;
                default -> null;
            };
        }
    }
}
