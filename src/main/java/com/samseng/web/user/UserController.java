package com.samseng.web.user;

import com.samseng.web.user.entity.User;
import com.samseng.web.user.dto.UserRegisterDTO;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.*;

import java.util.List;

@Path("/users")
@ApplicationScoped
@Transactional
public class UserController {
    @Inject
    private UserRepository userRepository;

    @GET
    @Produces("application/json")
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @POST
    @Consumes("application/json")
    public void register(UserRegisterDTO user) {
        var newUser = new User();
        newUser.setUsername(user.username);
        newUser.setPassword(user.password.getBytes());

        userRepository.insert(newUser);
    }
}