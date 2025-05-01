package com.lavacorp.beautefly.webstore.product.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/history/details")
public class ProductOrderDetails extends HttpServlet {
    private static final Map<String, Map<String, Object>> dummyOrders = new HashMap<>();

    static {
        // 初始化假订单数据
        Map<String, Object> order1 = new HashMap<>();
        order1.put("orderNumber", "BK1000001");
        order1.put("orderDate", "2025-04-27 15:30");
        order1.put("shippingName", "Ali Baba");
        order1.put("shippingPhone", "012-3456789");
        order1.put("shippingAddress", "123 Main Street, Kuala Lumpur, Malaysia");
        order1.put("paymentMethod", "Credit Card");
        order1.put("subtotal", 178.90);
        order1.put("shippingFee", 10.00);
        order1.put("totalAmount", 188.90);
        order1.put("status", "Order Placed".trim());
        order1.put("products", List.of(
                Map.of("name", "Minimalist Bag", "imageUrl", "https://...", "quantity", 1, "unitPrice", 89.00, "subtotal", 89.00),
                Map.of("name", "Wireless Earbuds", "imageUrl", "https://...", "quantity", 2, "unitPrice", 44.95, "subtotal", 89.90)
        ));

        Map<String, Object> order2 = new HashMap<>();
        order2.put("orderNumber", "BK1000002");
        order2.put("orderDate", "2025-04-28 10:15");
        order2.put("shippingName", "Chee Hua");
        order2.put("shippingPhone", "012-1111222");
        order2.put("shippingAddress", "456 Jalan Bukit, Selangor, Malaysia");
        order2.put("paymentMethod", "Online Banking");
        order2.put("subtotal", 45.50);
        order2.put("shippingFee", 0.00);
        order2.put("totalAmount", 45.50);
        order2.put("status", "Order Received".trim());
        order2.put("products", List.of(
                Map.of(
                        "name", "Stainless Steel Water Bottle",
                        "imageUrl", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQi3Fz5_XMRRnh19vUPn-hg7s724__VY5Kxig&s",
                        "quantity", 1,
                        "unitPrice", 45.50,
                        "subtotal", 45.50
                )
        ));

        dummyOrders.put("BK1000001", order1);
        dummyOrders.put("BK1000002", order2);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String orderId = req.getParameter("orderId");

        Map<String, Object> order = dummyOrders.get(orderId);

        if (order == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Order not found");
            return;
        }

        req.setAttribute("order", order);
        req.getRequestDispatcher("/WEB-INF/views/account/order-details.jsp").forward(req, resp);
    }
}

