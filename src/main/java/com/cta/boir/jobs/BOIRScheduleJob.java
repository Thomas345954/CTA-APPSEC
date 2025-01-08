package com.cta.boir.jobs;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

public class BOIRScheduleJob {

    public static void main(String[] args) {
        String endpointUrl = args[0];
        String requestBody = "{\"endpoint\":\"loadtranscriptjob\"}";
        sendPostRequest(endpointUrl, requestBody);
    }

    public static void sendPostRequest(String endpointUrl, String requestBody) {
        try {
            URL url = new URL(endpointUrl);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/json; utf-8");
            con.setRequestProperty("Accept", "application/json");
            con.setDoOutput(true);
            try (OutputStream os = con.getOutputStream()) {
                byte[] input = requestBody.getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }
            int responseCode = con.getResponseCode();
 
//            if (responseCode == HttpURLConnection.HTTP_OK) {
//                System.out.println("Request successful.");
//            } else {
//                System.out.println("Request failed.");
//            }

        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
        }
    }
}
