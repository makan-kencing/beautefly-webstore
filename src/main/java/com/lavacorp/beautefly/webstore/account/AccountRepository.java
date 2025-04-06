package com.lavacorp.beautefly.webstore.account;

import com.lavacorp.beautefly.webstore.account.entity.GuestAccount;
import com.lavacorp.beautefly.webstore.account.entity.UserAccount;
import jakarta.annotation.Nullable;
import jakarta.data.page.Page;
import jakarta.data.page.PageRequest;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import org.hibernate.query.Order;

import java.util.List;

public interface AccountRepository {
    UserAccount register(UserAccount account);

    GuestAccount createGuest(GuestAccount account);

    List<UserAccount> findByUsername(@NotBlank String username);

    @Nullable UserAccount findByEmail(@Email String email);

    Page<UserAccount> findByUsernameLike(@NotBlank String username, PageRequest page, List<Order<? super UserAccount>> orderBy);

    @Nullable GuestAccount findBySessionId(@NotBlank String sessionId);

    void update(UserAccount account);

    void delete(UserAccount account);
}
