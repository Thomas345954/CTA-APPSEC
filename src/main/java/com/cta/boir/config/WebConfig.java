package com.cta.boir.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.PathMatchConfigurer;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.resource.PathResourceResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@Configuration
@EnableWebMvc
public class WebConfig implements WebMvcConfigurer {
  @Bean
  public ViewResolver viewResolver() {
    final InternalResourceViewResolver bean = new InternalResourceViewResolver();
    bean.setViewClass(JstlView.class);
    bean.setPrefix("/WEB-INF/views/");
    bean.setSuffix(".jsp");
    return bean;
  }
  @Bean
	public RestTemplate restTemplate() {
		return new RestTemplate();
	}
  
  @Override
  public void configureViewResolvers(ViewResolverRegistry registry) {
    registry.viewResolver(viewResolver());
  }
  @Override
  public void configurePathMatch(PathMatchConfigurer configurer) {
      configurer.setUseSuffixPatternMatch(false);
      configurer.setUseTrailingSlashMatch(true);
     // configurer.setRemoveSemicolonContent(false); // Retain semicolon content
  }
  @Override
  public void addResourceHandlers(ResourceHandlerRegistry registry) {
      registry
          .addResourceHandler("/**")
          .addResourceLocations("classpath:/static/")
          .setCachePeriod(3600)
          .resourceChain(true)
          .addResolver(new PathResourceResolver());
  }
  
  @Override
  public void addViewControllers(ViewControllerRegistry registry) {
    registry.addViewController("/")
        .setViewName("forward:/home");
    registry.setOrder(Ordered.HIGHEST_PRECEDENCE);
  }
  
}