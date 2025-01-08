package com.cta.boir.controller;
  
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.UUID;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVPrinter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.json.JsonParser;
import org.springframework.boot.json.JsonParserFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.cta.boir.model.GeneratedCoupon;
import com.cta.boir.model.PaymentHistory;
import com.cta.boir.model.User;
import com.cta.boir.repository.GeneratedCouponRepository;
import com.cta.boir.service.GeneratedCouponService;
import com.cta.boir.service.PaymentHistoryService;
import com.cta.boir.service.UserService;
import com.cta.boir.service.WraperService;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;

@RestController
public class ChatBotController {
    
    @GetMapping("/nooffiles")
    public List<Map<String, Object>> getFiles() {
        List<Map<String, Object>> filesList = new ArrayList<>();

        // Adding coupon details as a map
        Map<String, Object> fileDetails = new HashMap<>();
        fileDetails.put("noOfFiles", 10); // Key-value pair for coupon detail

        // Adding the map to the list
        filesList.add(fileDetails);

        return filesList;
    }
}
