package com.cta.boir.config;

import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;

public class SecretKeyGenerator {
	public static SecretKey generateKey(int n) throws Exception {
		KeyGenerator keyGenerator = KeyGenerator.getInstance("AES");
		keyGenerator.init(n);
		// SecretKey secretKey = keyGenerator.generateKey();
		return keyGenerator.generateKey();
	}
}
