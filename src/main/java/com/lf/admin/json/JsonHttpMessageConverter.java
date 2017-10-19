package com.lf.admin.json;

import java.io.IOException;

import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.SerializationFeature;

public class JsonHttpMessageConverter extends MappingJackson2HttpMessageConverter {

	private Boolean enableRootWrap;

	private Boolean failOnUnknownProperties;

	public <T> T read(Class<T> clazz, String source) {
		try {
			return this.getObjectMapper().readValue(source, clazz);
		} catch (IOException ex) {
			ex.printStackTrace();
			throw new HttpMessageNotReadableException("Could not read JSON: " + ex.getMessage(), ex);
		}
	}

	public void setEnableRootWrap(Boolean enableRootWrap) {
		this.enableRootWrap = enableRootWrap;
		configureEnableRootWrap();
	}

	public void setFailOnUnknownProperties(Boolean failOnUnknownProperties) {
		this.failOnUnknownProperties = failOnUnknownProperties;
		configureFailOnUnknownProperties();
	}

	private void configureEnableRootWrap() {
		if (this.enableRootWrap != null) {
			this.getObjectMapper().configure(SerializationFeature.WRAP_ROOT_VALUE, this.enableRootWrap);
		}
	}

	private void configureFailOnUnknownProperties() {
		if (this.failOnUnknownProperties != null) {
			this.getObjectMapper().configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES,
					this.failOnUnknownProperties);
		}
	}
}
