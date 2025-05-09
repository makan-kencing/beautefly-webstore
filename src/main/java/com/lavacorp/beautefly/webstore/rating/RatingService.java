package com.lavacorp.beautefly.webstore.rating;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.entity.Account_;
import com.lavacorp.beautefly.webstore.file.FileService;
import com.lavacorp.beautefly.webstore.file.entity.FileUpload;
import com.lavacorp.beautefly.webstore.product.entity.Product;
import com.lavacorp.beautefly.webstore.rating.dto.RatingDTO;
import com.lavacorp.beautefly.webstore.rating.dto.RatingNewDTO;
import com.lavacorp.beautefly.webstore.rating.dto.RatingStatsDTO;
import com.lavacorp.beautefly.webstore.rating.dto.ReplyNewDTO;
import com.lavacorp.beautefly.webstore.rating.entity.Rating;
import com.lavacorp.beautefly.webstore.rating.entity.Rating_;
import com.lavacorp.beautefly.webstore.rating.entity.Reply;
import com.lavacorp.beautefly.webstore.rating.mapper.RatingMapper;
import com.lavacorp.beautefly.webstore.security.dto.AccountContextDTO;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.transaction.Transactional;
import org.hibernate.SessionFactory;
import org.hibernate.graph.GraphSemantic;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@Transactional
@ApplicationScoped
public class RatingService {
    @PersistenceUnit
    private EntityManagerFactory emf;

    @Inject
    private FileService fileService;

    @Inject
    private RatingMapper ratingMapper;

    public RatingDTO getRatingDetails(int ratingId) throws NoSuchElementException {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var graph = session.createEntityGraph(Rating.class);
        graph.addSubgraph(Rating_.account).addSubgraph(Account_.profileImage);
        graph.addPluralSubgraph(Rating_.images);
        graph.addPluralSubgraph(Rating_.replies);

        var rating = session.get(graph, GraphSemantic.FETCH, ratingId);
        if (rating == null)
            throw new NoSuchElementException("Rating with id " + ratingId + " does not exists.");
        return ratingMapper.toRatingDTO(rating);
    }

    public List<RatingDTO> getProductRatings(int productId) throws NoSuchElementException {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var graph = session.createEntityGraph(Rating.class);
        graph.addSubgraph(Rating_.account).addSubgraph(Account_.profileImage);
        graph.addPluralSubgraph(Rating_.images);
        graph.addPluralSubgraph(Rating_.replies);

        return session.createSelectionQuery("from Rating where product.id = :productId", Rating.class)
                .setEntityGraph(graph, GraphSemantic.FETCH)
                .setParameter("productId", productId)
                .getResultStream()
                .map(ratingMapper::toRatingDTO)
                .toList();
    }

    public void rate(RatingNewDTO newRating, AccountContextDTO user) throws IOException {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var account = new Account();
        account.setId(user.id());

        List<FileUpload> files = new ArrayList<>();
        for (var part : newRating.images()) {
            var file = fileService.save(part.getInputStream(), part.getSubmittedFileName());
            file.setCreatedBy(account);
            session.insert(file);

            files.add(file);
        }

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

    public RatingStatsDTO getProductRatingStats(int productId) {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var total = session.createSelectionQuery(
                        "select count(*) from Rating where product.id = :productId", Long.class
                ).setParameter("productId", productId)
                .getSingleResult();

        var average = session.createSelectionQuery(
                        "select avg(rating) from Rating where product.id = :productId", Double.class
                ).setParameter("productId", productId)
                .getSingleResult();

        var ratings = session.createSelectionQuery("""
                select rating, count(*)
                from Rating
                where product.id = :productId
                group by rating
            """, Object[].class)
                .setParameter("productId", productId)
                .stream()
                .collect(Collectors.toMap(
                        value -> (Integer) value[0],
                        value -> ((Long) value[1]).intValue()
                ));

        ratings.merge(1, 0, Integer::sum);
        ratings.merge(2, 0, Integer::sum);
        ratings.merge(3, 0, Integer::sum);
        ratings.merge(4, 0, Integer::sum);
        ratings.merge(5, 0, Integer::sum);

        return new RatingStatsDTO(
                total,
                average,
                ratings
        );
    }
}
