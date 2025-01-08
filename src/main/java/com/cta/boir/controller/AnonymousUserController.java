package com.cta.boir.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;



@RestController
@RequestMapping("/checkAnonymousUser")
public class AnonymousUserController {

    @GetMapping
    public String checkFirstTimeAnonymousUser(HttpServletRequest request, HttpServletResponse response) {
        // Check for a specific cookie
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("firstTimeVisitor".equals(cookie.getName())) {
                    return "false";
                }
            }
        }

        // If no cookie is found, set a new one for first-time users
       /* Cookie firstTimeCookie = new Cookie("firstTimeVisitor", "true");
        firstTimeCookie.setMaxAge(60 * 60 * 24 * 365); // Cookie lasts for a year
        firstTimeCookie.setHttpOnly(true); // Prevent JavaScript access for security
        firstTimeCookie.setPath("/");
        response.addCookie(firstTimeCookie);*/

        return "true";
    }
}
