package com.cta.boir.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/resetPassword")
public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
//        String email = (String) session.getAttribute("email");
//        String newPassword = request.getParameter("password");

        // Update the password in the database (pseudo code, implement as needed)
       // updatePassword(email, newPassword);

        // Invalidate the session to remove OTP and email attributes
        session.invalidate();

        // Redirect to a confirmation page or login page
        response.sendRedirect("login.jsp?message=Password successfully reset. Please log in.");
    }

    private void updatePassword(String email, String newPassword) {
        // Implement password update logic here
        // Example: Update password in the database
    }
}
