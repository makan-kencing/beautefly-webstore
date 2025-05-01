package com.lavacorp.beautefly.webstore.admin.product;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.admin.product.dto.*;
import com.lavacorp.beautefly.webstore.admin.product.mapper.AdminProductMapper;
import com.lavacorp.beautefly.webstore.file.FileService;
import com.lavacorp.beautefly.webstore.product.ProductService;
import com.lavacorp.beautefly.webstore.product.entity.Category;
import com.lavacorp.beautefly.webstore.product.entity.Color;
import com.lavacorp.beautefly.webstore.product.entity.Product;
import com.lavacorp.beautefly.webstore.product.entity.Product_;
import com.lavacorp.beautefly.webstore.security.dto.AccountContextDTO;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.transaction.Transactional;
import org.hibernate.SessionFactory;
import org.hibernate.graph.GraphSemantic;

import java.io.IOException;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

@Transactional
@ApplicationScoped
public class AdminProductService {
    @PersistenceUnit
    private EntityManagerFactory emf;

    @Inject
    private FileService fileService;

    @Inject
    private ProductService productService;

    @Inject
    private AdminProductMapper productMapper;

    public ProductDetailsDTO getProductDetails(int productId) {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var graph = session.createEntityGraph(Product.class);
        graph.addSubgraph(Product_.category);
        graph.addSubgraph(Product_.color);
        graph.addPluralSubgraph(Product_.images);

        var product = session.get(graph, GraphSemantic.FETCH, productId);

        return productMapper.toProductDetailsDTO(product);
    }

    public void createProduct(CreateProductDTO dto) {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var product = new Product();

        //noinspection DuplicatedCode
        product.setName(dto.name());
        product.setDescription(dto.description());
        product.setBrand(dto.brand());
        product.setReleaseDate(dto.releaseDate());
        product.setUnitPrice(dto.unitPrice());
        product.setUnitCost(dto.unitCost());
        product.setStockCount(dto.stockCount());

        var category = new Category();
        category.setId(dto.categoryId());

        product.setCategory(category);

        if (dto.colorId() != null) {
            var color = new Color();
            color.setId(dto.colorId());

            product.setColor(color);
        }

        session.insert(product);
    }

    public void editProduct(EditProductDTO dto) throws NoSuchElementException {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var product = session.get(Product.class, dto.id());
        if (product == null)
            throw new NoSuchElementException();

        //noinspection DuplicatedCode
        product.setName(dto.name());
        product.setDescription(dto.description());
        product.setBrand(dto.brand());
        product.setReleaseDate(dto.releaseDate());
        product.setUnitPrice(dto.unitPrice());
        product.setUnitCost(dto.unitCost());
        product.setStockCount(dto.stockCount());

        if (dto.categoryId() != null) {
            var category = new Category();
            category.setId(dto.categoryId());

            product.setCategory(category);
        }

        if (dto.colorId() != null) {
            var color = new Color();
            color.setId(dto.colorId());

            product.setColor(color);
        }

        session.update(product);
    }

    public void deleteProducts(DeleteProductDTO dto) {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        for (var id : dto.id()) {
            var product = new Product();
            product.setId(id);

            session.delete(product);
        }
    }

    public void uploadProductImage(AccountContextDTO user, UploadProductImageDTO dto) throws NoSuchElementException, IOException {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var graph = session.createEntityGraph(Product.class);
        graph.addPluralSubgraph(Product_.images);

        var product = session.get(graph, GraphSemantic.FETCH, dto.id());
        if (product == null)
            throw new NoSuchElementException();

        var createdBy = new Account();
        createdBy.setId(user.id());

        var file = fileService.save(dto.image().getInputStream(), dto.image().getSubmittedFileName());
        file.setCreatedBy(createdBy);

        product.getImages().add(file);

        session.insert(file);
        session.update(product);
    }

    public void removeProductImage(RemoveProductImageDTO dto) {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var graph = session.createEntityGraph(Product.class);
        graph.addPluralSubgraph(Product_.images);

        var product = session.get(graph, GraphSemantic.FETCH, dto.id());
        if (product == null)
            return;

        product.setImages(
                product.getImages().stream()
                        .filter(i -> i.getId() != dto.imageId())
                        .collect(Collectors.toSet())
        );

        session.update(product);
    }

    public CreateProductContext getCreateProductContext() {
        return new CreateProductContext(
                productService.getAvailableCategoryTree(),
                productService.getAvailableColors(),
                productService.getExistingBrands()
        );
    }
}
