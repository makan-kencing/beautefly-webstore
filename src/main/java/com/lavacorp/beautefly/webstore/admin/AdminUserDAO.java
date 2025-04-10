package com.lavacorp.beautefly.webstore.admin;

import com.lavacorp.beautefly.webstore.account.entity.UserAccount;
import com.lavacorp.beautefly.webstore.account.entity.Credential;
import jakarta.enterprise.context.ApplicationScoped;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@ApplicationScoped
public class AdminUserDAO {
    public List<UserAccount> getAllUsers() {
        List<UserAccount> users = new ArrayList<>();

        //User 1
        UserAccount u1 = new UserAccount();
        u1.setUsername("alexang0325");
        u1.setEmail("alexang0325@gmail.com");
        u1.setActive(true);

        Credential c1 = new Credential();
        c1.setRoles(Set.of(Credential.Role.USER, Credential.Role.STAFF));
        u1.setCredential(c1);

        users.add(u1);

        //User 2
        UserAccount u2 = new UserAccount();
        u2.setUsername("testadmin");
        u2.setEmail("admin@example.com");
        u2.setActive(true);

        Credential c2 = new Credential();
        c2.setRoles(Set.of(Credential.Role.USER, Credential.Role.ADMIN));
        u2.setCredential(c2);

        users.add(u2);

        return users;

    }
}
