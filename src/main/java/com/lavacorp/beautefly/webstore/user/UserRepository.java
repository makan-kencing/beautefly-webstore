package com.lavacorp.beautefly.webstore.user;

import com.lavacorp.beautefly.webstore.user.entity.User;
import jakarta.annotation.Nullable;
import jakarta.data.repository.*;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

import java.util.List;

@Transactional
@Repository
public interface UserRepository {
    @Find
    List<User> findAll();

    @Find
    @Nullable
    User findByUsername(@NotBlank String username);

    @Find
    @Nullable
    User findByEmail(@Email String email);

    @Insert
    void insert(@Valid User user);

    @Save
    void save(@Valid User user);

    @Delete
    void delete(@Valid User user);
}
