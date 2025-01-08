package com.cta.boir.service;

import com.cta.boir.dto.FileDto;
import com.cta.boir.exception.GCPFileUploadException;
import com.cta.boir.exception.InvalidFileTypeException;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.storage.Blob;
import com.google.cloud.storage.Bucket;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;
import org.apache.commons.lang3.RandomStringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;

@Component
public class DataBucketService {

    private static final Logger LOGGER = LoggerFactory.getLogger(DataBucketService.class);

    @Value("${gcp.config.file}")
    private String gcpConfigFile;

    @Value("${gcp.project.id}")
    private String gcpProjectId;

    @Value("${gcp.bucket.id}")
    private String gcpBucketId;
    
    @Value("${gcp.bucket.profile.id}")
    private String gcpBucketProfileId;
    
    @Value("${gcp.dir.name}")
    private String gcpDirectoryName;

    @Value("${gcp.dir.profile.name}")
    private String gcpDirectoryProfileName;

    public FileDto uploadFile(MultipartFile multipartFile, String fileName, String contentType, String type) {

        try{

        	String bucketName;
        	String directoryName;
        	if(type!=null && type.equalsIgnoreCase("profile")) {
        		bucketName=gcpBucketProfileId;
        		directoryName=gcpDirectoryProfileName;
        	}else {
        		bucketName=gcpBucketId;
        		directoryName=gcpDirectoryName;
        	} 
            LOGGER.debug("Start file uploading process on GCS");
            byte[] fileData = multipartFile.getBytes();

            InputStream inputStream = new ClassPathResource(gcpConfigFile).getInputStream();

            StorageOptions options = StorageOptions.newBuilder().setProjectId(gcpProjectId)
                    .setCredentials(GoogleCredentials.fromStream(inputStream)).build();

            Storage storage = options.getService();
            Bucket bucket = storage.get(bucketName,Storage.BucketGetOption.fields());

            Blob blob = bucket.create(directoryName + "/" + fileName, fileData, contentType);

            if(blob != null){
                LOGGER.debug("File successfully uploaded to GCS");
                return new FileDto(fileName, blob.getMediaLink());
            }

        }catch (Exception e){
            LOGGER.error("An error occurred while uploading data. Exception: ", e);
            throw new GCPFileUploadException("An error occurred while storing data to GCS");
        }
        throw new GCPFileUploadException("An error occurred while storing data to GCS");
    }

    

    private String checkFileExtension(String fileName) {
        if(fileName != null && fileName.contains(".")){
            String[] extensionList = {".png", ".jpeg", ".pdf", ".doc"};

            for(String extension: extensionList) {
                if (fileName.endsWith(extension)) {
                    LOGGER.debug("Accepted file type : {}", extension);
                    return extension;
                }
            }
        }
        LOGGER.error("Not a permitted file type");
        throw new InvalidFileTypeException("Not a permitted file type");
    }
}