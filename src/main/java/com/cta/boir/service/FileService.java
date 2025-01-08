package com.cta.boir.service;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.cta.boir.dto.FileDto;
import com.cta.boir.exception.BadRequestException;
import com.cta.boir.exception.GCPFileUploadException;
import com.cta.boir.vo.DocumentResponse;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class FileService {

	private static final Logger LOGGER = LoggerFactory.getLogger(FileService.class);

	private final DataBucketService dataBucketService;

	@Autowired
	DocumentAiService documentAiService;

	public FileService(DataBucketService dataBucketService) {
		this.dataBucketService = dataBucketService;
	}

	public List<FileDto> uploadFiles1(MultipartFile files, String type) {

		LOGGER.debug("Start file uploading service");
		List<FileDto> inputFiles = new ArrayList<>();

		Collections.singletonList(files).forEach(file -> {
			String originalFileName = file.getOriginalFilename();
			if (originalFileName == null) {
				throw new BadRequestException("Original file name is null");
			}
			Path path = new File(originalFileName).toPath();

			try {
				String contentType = Files.probeContentType(path);
				String sanitizedFileName = sanitizeFileName(originalFileName);
				FileDto fileDto = dataBucketService.uploadFile(file, sanitizedFileName, contentType, type);

				if (fileDto != null) {
					inputFiles.add(fileDto);
					LOGGER.info("File uploaded successfully, file name: {} and url: {}", fileDto.getFileName(),
							fileDto.getFileUrl());
				}
			} catch (Exception e) {
				e.printStackTrace();
				LOGGER.error("Error occurred while uploading. Error: ", e);
				throw new GCPFileUploadException("Error occurred while uploading");
			}
		});
		return inputFiles;
	}

	public static String sanitizeFileName(String fileName) {
		// Separate the file name and extension
		int lastDotIndex = fileName.lastIndexOf('.');
		String namePart = lastDotIndex > 0 ? fileName.substring(0, lastDotIndex) : fileName;
		String extensionPart = lastDotIndex > 0 ? fileName.substring(lastDotIndex) : "";
		// Get the current timestamp
		String timeStamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		// Remove all special characters except for _
		namePart = namePart.replaceAll("[^a-zA-Z0-9_]", "");
		// Append the timestamp to the sanitized name
		namePart = namePart + "_" + timeStamp;
		// Reconstruct the file name
		return namePart + extensionPart;
	}

	public List<FileDto> uploadFiles(MultipartFile files, String documentType, String type) {
		LOGGER.debug("Start file uploading service");
		List<FileDto> inputFiles = new ArrayList<>();
		List<String> allowedExtensions = Arrays.asList("jpeg", "jpg", "png", "pdf", "tiff");

		Collections.singletonList(files).forEach(file -> {
			String originalFileName = file.getOriginalFilename();

			if (originalFileName == null) {
				throw new BadRequestException("Original file name is null");
			}

			String fileExtension = getFileExtension(originalFileName).toLowerCase();
			if (!allowedExtensions.contains(fileExtension)) {
				throw new BadRequestException("File type not allowed. Allowed types are: JPEG, JPG, PNG, PDF, TIFF");
			}

			try {
				String contentType = file.getContentType();
				if (contentType == null || !isAllowedContentType(contentType)) {
					throw new BadRequestException("Invalid content type. Allowed types are: JPEG, JPG, PNG, PDF, TIFF");
				}

				String sanitizedFileName = sanitizeFileName(originalFileName);
				FileDto fileDto = dataBucketService.uploadFile(file, sanitizedFileName, contentType, type);

				if (fileDto != null) {
					inputFiles.add(fileDto);
					LOGGER.info("File uploaded successfully, file name: {} and url: {}", fileDto.getFileName(),
							fileDto.getFileUrl());
					DocumentResponse response =null;
					if(documentType.equalsIgnoreCase("39") || documentType.equalsIgnoreCase("40")) {
						String url = "https://us-documentai.googleapis.com/v1/projects/498996850221/locations/us/processors/4a9c7f5748ccdc7c/processorVersions/636f08e084ac9a06:process";
						response = documentAiService.getFileData(file, contentType, url,documentType);
					}else if(documentType.equalsIgnoreCase("37")) {
						//String url ="https://us-documentai.googleapis.com/v1/projects/498996850221/locations/us/processors/4a9c7f5748ccdc7c/processorVersions/a90996d307dd899b:process"; //driving license url
						String url ="https://us-documentai.googleapis.com/v1/projects/498996850221/locations/us/processors/4a9c7f5748ccdc7c/processorVersions/f7e8e1d4fa8a02b4:process";
						response = documentAiService.getFileData(file, contentType, url, documentType);

					}else if(documentType.equalsIgnoreCase("38")) {
						String url ="https://us-documentai.googleapis.com/v1/projects/498996850221/locations/us/processors/4a9c7f5748ccdc7c/processorVersions/e4555f569a1edf41:process"; //trbal card url
						response = documentAiService.getFileData(file, contentType, url, documentType);

					}

					fileDto.setResponse(response);
				}
			} catch (Exception e) {
				LOGGER.error("Error occurred while uploading. Error: ", e);
				throw new GCPFileUploadException("Error occurred while uploading: " + e.getMessage());
			}
		});
		return inputFiles;
	}

	private String getFileExtension(String fileName) {
		int lastIndexOf = fileName.lastIndexOf(".");
		if (lastIndexOf == -1) {
			return ""; // empty extension
		}
		return fileName.substring(lastIndexOf + 1);
	}

	private boolean isAllowedContentType(String contentType) {
		List<String> allowedContentTypes = Arrays.asList("image/jpeg", "image/jpg", "image/png", "application/pdf",
				"image/tiff");
		return allowedContentTypes.contains(contentType.toLowerCase());
	}
}
