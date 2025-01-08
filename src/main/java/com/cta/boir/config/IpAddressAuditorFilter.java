package com.cta.boir.config;

import java.io.IOException;

import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class IpAddressAuditorFilter extends OncePerRequestFilter {

    private static final ThreadLocal<String> currentIpAddress = new ThreadLocal<>();

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        // Get the IP address from the X-Forwarded-For header if available
        String ipAddress = request.getHeader("X-Forwarded-For");
        if (ipAddress == null || ipAddress.isEmpty()) {
            ipAddress = request.getRemoteAddr(); // Fallback to remote address
        } else {
            // X-Forwarded-For can contain a list of IPs; get the first one
            ipAddress = ipAddress.split(",")[0].trim();
        }

        currentIpAddress.set(ipAddress);

        try {
            filterChain.doFilter(request, response);
        } finally {
            currentIpAddress.remove(); // Clean up after request is processed
        }
    }

    public static String getCurrentIpAddress() {
        return currentIpAddress.get();
    }
}
