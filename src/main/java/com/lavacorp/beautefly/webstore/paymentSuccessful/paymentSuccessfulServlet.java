package com.lavacorp.beautefly.webstore.paymentSuccessful;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/paymentSuccessful")
public class paymentSuccessfulServlet extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 转发到 index.jsp 页面
        String paymentSuccessful = "true";
        request.setAttribute("paymentSuccessful", paymentSuccessful);
        request.getRequestDispatcher("paymentSuccessful.jsp").forward(request, response);
    }




}
