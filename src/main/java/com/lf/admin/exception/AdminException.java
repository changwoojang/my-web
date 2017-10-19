package com.lf.admin.exception;

import org.springframework.core.NestedRuntimeException;
import org.springframework.http.HttpStatus;

@SuppressWarnings("serial")
public abstract class AdminException extends NestedRuntimeException {

	private HttpStatus status;

	private String code;

	public AdminException(String message) {
		super(message);
	}

	public AdminException(String code, String message) {
		super(message);
		this.code = code;
	}

	public AdminException(String message, HttpStatus status, String code) {
		super(message);
		this.status = status;
		this.code = code;
	}

	public HttpStatus getStatus() {
		return status;
	}

	public void setStatus(HttpStatus status) {
		this.status = status;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

}
