package com.cta.boir.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller

public class OtpDataController {
    
    @GetMapping("/otp")
    public String terms() {
        return "otp-data";
    }
}
