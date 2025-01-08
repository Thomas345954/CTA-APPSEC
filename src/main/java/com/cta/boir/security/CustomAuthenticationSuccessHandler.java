package com.cta.boir.security;
import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException {
//        if (authentication != null) {
//            System.out.println("Authenticated User: " + authentication.getPrincipal());
//        } else {
//            System.out.println("Authentication object is null.");
//        }
        response.sendRedirect("/home"); // Redirect to the desired page after successful login
    }
}
