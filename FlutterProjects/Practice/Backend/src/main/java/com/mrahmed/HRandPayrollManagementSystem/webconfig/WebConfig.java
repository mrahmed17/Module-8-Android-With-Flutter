package com.mrahmed.HRandPayrollManagementSystem.webconfig;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Value("${upload.directory}")
    private String uploadDirectory;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/uploadDirectory/**")
                .addResourceLocations("file:" + uploadDirectory + "/");

        registry.addResourceHandler("/resources/**")
                .addResourceLocations("/resources/");

        WebMvcConfigurer.super.addResourceHandlers(registry);
    }

    /*@Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/**") // Applies to all endpoints
                        .allowedOrigins("*") // Allows all origins
                        .allowedMethods("*") // Allows all HTTP methods
                        .allowedHeaders("*"); // Allows all headers
            }
        };
    }*/


    /*@Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/api/**")
                        .allowedOrigins("http://localhost:4200", "http://localhost:8081", "http://127.0.0.1:8081")
                        .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS");
//                        .allowedHeaders("*");
//                        .allowCredentials(true);
                registry.addMapping("/images/**")
                        .allowedOrigins("http://localhost:4200", "http://localhost:8081", "http://127.0.0.1:8081")
                        .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS");
//                        .allowedHeaders("*");
//                        .allowCredentials(true);
            }
        };
    }*/
}
