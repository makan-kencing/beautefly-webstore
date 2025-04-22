package com.lavacorp.beautefly.webstore.account.servlet;

import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

@WebServlet("/address/delete")
@ServletSecurity(@HttpConstraint(rolesAllowed = {"*"}))
public class DeleteAddressServlet extends HttpServlet {
}
