package com.cta.boir.controller;

import com.cta.boir.model.PaymentHistory;
import com.cta.boir.model.User;
import com.cta.boir.service.PaymentHistoryService;
import com.cta.boir.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
//@RequestMapping
public class PaymentHistoryController {
    @Autowired
    private PaymentHistoryService paymentHistoryService;
    @Autowired
    private  UserService us;

    @GetMapping("/paymenthistory")
    public String getAllPaymentHistory(Model model) {
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    String principalName = "";
    if (authentication != null) {
        principalName = authentication.getName();
    }

    User uservo = us.findByEmail(principalName);
    List<PaymentHistory> paymentHistory = paymentHistoryService.wherePaymentHistoryByUser(String.valueOf(uservo.getEmail()));
    model.addAttribute("paymentHistory", paymentHistory);
    return "payment-history";
    
    }

    @GetMapping("/newpaymenthistory")
    public String showCreateForm(Model model) {
         model.addAttribute("paymentHistory", new PaymentHistory());
        return "payment-history-form";
    }

    @PostMapping
    public String createPaymentHistory(@ModelAttribute PaymentHistory paymentHistory) {
    	paymentHistoryService.savePaymentHistory(paymentHistory);
        return "redirect:/paymenthistory";
    }

    @GetMapping("/editph/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
    	PaymentHistory paymentHistory = paymentHistoryService.getPaymentHistoryById(id).orElseThrow(() -> new IllegalArgumentException("Invalid paymentHistory Id:" + id));
        model.addAttribute("paymentHistory", paymentHistory);
        return "payment-history-form";
    }

    @PostMapping("/updateph/{id}")
    public String updatePaymentHistory(@PathVariable Long id, @ModelAttribute PaymentHistory paymentHistory) {
    	paymentHistoryService.savePaymentHistory(paymentHistory);
        return "redirect:/paymenthistory";
    }

    @GetMapping("/deleteph/{id}")
    public String deletePaymentHistory(@PathVariable Long id) {
    	paymentHistoryService.deletePaymentHistory(id);
        return "redirect:/paymenthistory";
    }
}
