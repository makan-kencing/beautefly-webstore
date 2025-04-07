package com.lavacorp.beautefly.webstore.home.servlet;


import com.lavacorp.beautefly.webstore.home.dto.MainPromoDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class MainPageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<MainPromoDTO> promos = List.of(
                new MainPromoDTO("https://cdn.shopify.com/s/files/1/0070/7032/files/how-to-start-a-skincare-line-glow-oasis.jpg?v=1666895341", "Skin Care", "Skincare range for a healthy, radiant complexion."),
                new MainPromoDTO("https://t4.ftcdn.net/jpg/02/73/55/33/360_F_273553300_sBBxIPpLSn5iC5vC8FwzFh6BJDKvUeaC.jpg", "Makeup", "Makeup products to enhance your beautiful look."),
                new MainPromoDTO("https://www.everkindnz.com/cdn/shop/files/everkind-bodycare-that-is-caring-by-nature-mobile-hero-home-page-white-roses-double-compressed-1024px_1600x.jpg?v=1711690743", "Body Care", "Body care products to pamper every inch of your skin."),
                new MainPromoDTO("https://hourshaircare.com/cdn/shop/files/find_your_ritual_img.jpg?v=1712143676", "Hair Care", "Hair care for smoother, shinier locks."),
                new MainPromoDTO("https://img.freepik.com/free-photo/top-view-still-life-assortment-nail-care-products_23-2148974551.jpg", "Beauty Tools & Devices", "Beauty tools to make skincare more effective."),
                new MainPromoDTO("https://cdn.prod.website-files.com/63ee8aa635ba278b3ee2d76a/66b0d9d9b17b539efeca321f_66b0d98d0bd07e791ead732b_3.jpeg", "Special Treatments", "Professional care solutions for specific skin concerns.")
        );

        req.setAttribute("promos", promos);
        var view = req.getRequestDispatcher("mainpage.jsp");
        view.forward(req, resp);
    }
}
