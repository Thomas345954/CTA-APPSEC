package com.cta.boir.controller;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.Random;

import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.cta.boir.dto.UserDto;
import com.cta.boir.model.OtpData;

import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;





@WebServlet("/sendOTPoriginal")
public class SendOTPServlet extends jakarta.servlet.http.HttpServlet {
    private static final long serialVersionUID = 1L;

    
    
    
    private static final SecureRandom secureRandom = new SecureRandom(); 
    public static int generateOtp() {
        return secureRandom.nextInt(900000) + 100000;
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userEmail = request.getParameter("forgotemail");
        
        // Generate OTP
        int otp = generateOtp();
        
        sendOtpToEmail(userEmail, otp);
        
        // Store OTP in session
        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);
        session.setAttribute("email", userEmail);
        
        // Redirect to OTP validation page
        response.sendRedirect("validateOTP.jsp");
    }

    private void sendOtpToEmail(String email, int otp) {
         // Implement email sending logic here
        // Example: Send email using JavaMail API
    }
}

