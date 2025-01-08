package com.cta.boir;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.scheduling.annotation.EnableAsync;

@SpringBootApplication
//@EnableJpaAuditing(auditorAwareRef = "auditorProvider")
@EnableAsync
public class BoirApplication extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		return builder.sources(BoirApplication.class);
	}

	public static void main(String[] args) {
		SpringApplication.run(BoirApplication.class, args);
	}

}
