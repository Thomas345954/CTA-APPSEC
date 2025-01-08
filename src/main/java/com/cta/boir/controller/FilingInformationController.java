package com.cta.boir.controller;

import com.cta.boir.model.Employee;
import com.cta.boir.service.EmployeeService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class FilingInformationController {
    @Autowired
    private EmployeeService employeeService;

    @GetMapping("/filing")
    public String getFilingInformation(Model model) {
        return "filing-information";
    }

    
}
