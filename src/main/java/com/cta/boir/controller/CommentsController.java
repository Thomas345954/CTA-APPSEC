package com.cta.boir.controller;


import com.cta.boir.model.Comments;
import com.cta.boir.service.CommentsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class CommentsController {
    @Autowired
    private CommentsService commentsService;

    @GetMapping
    public String getAllEmployees(Model model) {
        List<Comments> comments = commentsService.getAllComments();
        model.addAttribute("comments", comments);
        return "comments";
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("comments", new Comments());
        return "employee-form";
    }


    
}
