package com.hub.root.member.config;

import org.springframework.web.multipart.commons.CommonsMultipartResolver;

//@Configuration
public class MemberFileConfig {
//	@Bean
	public CommonsMultipartResolver multipartResolver() {
		CommonsMultipartResolver mr = new CommonsMultipartResolver();
		mr.setMaxUploadSize(52428800);
		mr.setDefaultEncoding("utf-8");
		return mr;
	}
}
