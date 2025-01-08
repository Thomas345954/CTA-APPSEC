package com.cta.boir.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.cta.boir.dto.FileDto;
import com.cta.boir.service.FileService;

@Controller
@RequestMapping("upload")
public class FileController {

    final FileService fileService;

    public FileController(FileService fileService) {
        this.fileService = fileService;
    }


    @PostMapping
    @ResponseBody
    public FileDto uploadFile(@RequestPart("file") MultipartFile files, @RequestParam("documentType") String documentType) {
    	
        return fileService.uploadFiles(files, documentType, "document").get(0);
    }
    @PostMapping("/profile")
    @ResponseBody
    public FileDto uploadProfileFile(@RequestPart("file") MultipartFile files, @RequestParam("documentType") String documentType) {
    	
        return fileService.uploadFiles(files, documentType, "profile").get(0);
    }


}
