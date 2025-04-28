package com.lavacorp.beautefly.webstore.rating;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.file.FileService;
import com.lavacorp.beautefly.webstore.file.entity.FileUpload;
import com.lavacorp.beautefly.webstore.product.entity.Product;
import com.lavacorp.beautefly.webstore.rating.dto.RatingNewDTO;
import com.lavacorp.beautefly.webstore.rating.dto.ReplyNewDTO;
import com.lavacorp.beautefly.webstore.rating.entity.Rating;
import com.lavacorp.beautefly.webstore.rating.entity.Reply;
import com.lavacorp.beautefly.webstore.security.dto.AccountContextDTO;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.transaction.Transactional;
import org.hibernate.SessionFactory;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

@Transactional
@ApplicationScoped
public class RatingService {
    @PersistenceUnit
    private EntityManagerFactory emf;

    @Inject
    private FileService fileService;

    public void rate(RatingNewDTO newRating, AccountContextDTO user) throws IOException {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        List<FileUpload> files = new ArrayList<>();
        for (var part : newRating.images()) {
            var file = fileService.save(part.getInputStream(), part.getSubmittedFileName());
            session.insert(file);

            files.add(file);
        }
        var account = new Account();
        account.setId(user.id());

        var product = new Product();
        product.setId(newRating.productId());

        var rating = new Rating();
        rating.setAccount(account);
        rating.setProduct(product);
        rating.setTitle(newRating.title());
        rating.setRating(newRating.rating());
        rating.setMessage(newRating.message());
        rating.setImages(new HashSet<>(files));

        session.insert(rating);
    }

    public void reply(ReplyNewDTO newReply, AccountContextDTO user) {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var original = new Rating();
        original.setId(newReply.originalId());

        var account = new Account();
        account.setId(user.id());

        var reply = new Reply();
        reply.setMessage(newReply.message());
        reply.setOriginal(original);
        reply.setAccount(account);

        session.insert(reply);
    }
}
