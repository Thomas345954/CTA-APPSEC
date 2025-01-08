package com.cta.boir.service;

import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.security.spec.KeySpec;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.cta.boir.controller.CheckoutController;

@Service
public class EncryptDecrypt {

	private EncryptDecrypt() {
		
	}
	
	
	 @Value("${cta.enc.secret}") private String secret;
	 @Value("${cta.enc.salt}") private String salt;
	
	String cAlgo = "AES/CBC/PKCS5Padding";
	SecureRandom random = new SecureRandom();
	public String encrypt(String strToEncrypt) {
		
		try {
			//String secret = "FPPJhiUqJToZU/w1eRe3mGz7fQojoY9wWJOJeveJ1rk=";//System.getenv("encryptor_password");
			//String salt = "y5=yG@gqGJ6f?vbn";//System.getenv("encryptor_salt");
//			byte[] iv = new byte[16]; //secure random IV is not possible, since every
                                      //time random value will be generated and it will
                                      //not match with the encrypted random hence it 
                                      //will failed to decrypt. our use case it will not fit.
			//random.nextBytes(iv);
	        CheckoutController c = new CheckoutController();
	        IvParameterSpec ivspec = c.generateRandomIV();
			SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
			KeySpec spec = new PBEKeySpec(secret.toCharArray(), salt.getBytes(), 65536, 256);
			SecretKey tmp = factory.generateSecret(spec);
			SecretKeySpec secretKey = new SecretKeySpec(tmp.getEncoded(), "AES");
			Cipher cipher = Cipher.getInstance(cAlgo);
			cipher.init(Cipher.ENCRYPT_MODE, secretKey, ivspec);
			return Base64.getEncoder().encodeToString(cipher.doFinal(strToEncrypt.getBytes(StandardCharsets.UTF_8)));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public String decrypt(String strToDecrypt) {
		try {
			//String secret = "FPPJhiUqJToZU/w1eRe3mGz7fQojoY9wWJOJeveJ1rk=";//System.getenv("encryptor_password");
			//String salt = "y5=yG@gqGJ6f?vbn";//System.getenv("encryptor_salt");
//			byte[] iv = new byte[16]; //secure random IV is not possible, since every
			                          //time random value will be generated and it will
			                          //not match with the encrypted random hence it 
			                          //will failed to decrypt. our use case it will not fit.
			//random.nextBytes(iv);
			CheckoutController c = new CheckoutController();
            IvParameterSpec ivspec = c.generateRandomIV();
			SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
			KeySpec spec = new PBEKeySpec(secret.toCharArray(), salt.getBytes(), 65536, 256);
			SecretKey tmp = factory.generateSecret(spec);
			SecretKeySpec secretKey = new SecretKeySpec(tmp.getEncoded(), "AES");
			Cipher cipher = Cipher.getInstance(cAlgo);
			cipher.init(Cipher.DECRYPT_MODE, secretKey, ivspec);
			return new String(cipher.doFinal(Base64.getDecoder().decode(strToDecrypt)));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
