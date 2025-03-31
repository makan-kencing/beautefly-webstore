package com.lavacorp.beautefly.webstore.admin.model;

import lombok.Data;

@Data
public class UsersStats {
    private int id;
    private String username;
    private String firstName;
    private String lastName;
    private String email;
    private int groupId;
    private boolean staff;
    private boolean superuser;
    private boolean active;
}
