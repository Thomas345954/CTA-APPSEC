package com.cta.boir.config;

import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;

import com.cta.boir.controller.CheckoutController;

public class EncryptionUtil {

	private static final String ALGORITHM = "AES/CBC/PKCS5Padding";

	public static String encrypt(String data, SecretKey secretKey, IvParameterSpec iv) throws Exception {
		Cipher cipher = Cipher.getInstance(ALGORITHM);
		cipher.init(Cipher.ENCRYPT_MODE, secretKey, iv);
		byte[] encryptedBytes = cipher.doFinal(data.getBytes());
		return Base64.getEncoder().encodeToString(encryptedBytes);
	}

	public static String decrypt(String encryptedData, SecretKey secretKey, IvParameterSpec iv) throws Exception {
		Cipher cipher = Cipher.getInstance(ALGORITHM);
		cipher.init(Cipher.DECRYPT_MODE, secretKey, iv);
		byte[] decryptedBytes = cipher.doFinal(Base64.getDecoder().decode(encryptedData));
		return new String(decryptedBytes);
	}

	public static void main(String[] args) {
		try {
			// Generate a secret key
			SecretKey secretKey = SecretKeyGenerator.generateKey(128);
//            Arrays.toString(secretKey.getEncoded());
			// Generate an IV (initialization vector)
			CheckoutController c = new CheckoutController();
			IvParameterSpec iv = c.generateRandomIV();

			// Encrypt and decrypt data
			String originalData = "2173812732183123182973123781";
			String encryptedData = encrypt(originalData, secretKey, iv);
			decrypt(encryptedData, secretKey, iv);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
