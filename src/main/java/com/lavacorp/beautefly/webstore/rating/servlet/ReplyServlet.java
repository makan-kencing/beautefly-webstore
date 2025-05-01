package com.lavacorp.beautefly.webstore.rating.servlet;

import com.lavacorp.beautefly.webstore.rating.RatingService;
import com.lavacorp.beautefly.webstore.rating.mapper.RatingMapper;
import com.lavacorp.beautefly.webstore.security.filter.UserContextFilter;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.hibernate.SessionFactory;

import java.io.IOException;

@WebServlet("/reply")
@ServletSecurity(@HttpConstraint(rolesAllowed = {"*"}))
public class ReplyServlet extends HttpServlet {
    @Inject
    private RatingMapper ratingMapper;

    @Inject
    private RatingService ratingService;

    @PersistenceUnit
    private EntityManagerFactory emf;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var user = UserContextFilter.getUserContext(req);
        assert user != null;

        var newReply = ratingMapper.toReplyNewDTO(req);

        // TODO: move into service or something
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();
        var productId = session.createSelectionQuery("select product.id from Rating where id = :ratingId", Integer.class)
                .setParameter("ratingId", newReply.originalId())
                .getSingleResultOrNull();

        if (productId == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        ratingService.reply(newReply, user);

        resp.sendRedirect("/product/" + productId);
    }
}
