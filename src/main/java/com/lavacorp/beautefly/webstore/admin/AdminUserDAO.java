package com.lavacorp.beautefly.webstore.admin;

import com.lavacorp.beautefly.webstore.admin.model.UsersStats;
import jakarta.enterprise.context.ApplicationScoped;
import java.util.ArrayList;
import java.util.List;

@ApplicationScoped
public class AdminUserDAO {
    public List<UsersStats> getAllUsers() {
        List<UsersStats> users = new ArrayList<>();

        UsersStats u1 = new UsersStats();
        u1.setUsername("Alexang0325");
        u1.setFirstName("Ang");
        u1.setLastName("Ru Seng");
        u1.setEmail("alexang0325@gmail.com");
        u1.setGroupId(1);
        u1.setStaff(true);
        u1.setSuperuser(false);
        u1.setActive(true);
        users.add(u1);

        UsersStats u2 = new UsersStats();
        u2.setUsername("Mibo");
        u2.setFirstName("Mi");
        u2.setLastName("Bo");
        u2.setEmail("mibo@gmail.com");
        u2.setGroupId(1);
        u2.setStaff(false);
        u2.setSuperuser(false);
        u2.setActive(false);
        users.add(u2);

        return users;
    }
}
