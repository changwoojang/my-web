package com.lf.admin.handler;

import org.springframework.http.HttpStatus;
import org.springframework.util.Assert;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonRootName;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.google.common.base.Objects;
import com.lf.admin.json.HttpStatusSerializer;

@JsonRootName("error")
public class RestError {

	@JsonSerialize(using = HttpStatusSerializer.class)
	private final HttpStatus status;

	private final String code;

	private final String message;

	@JsonProperty("exception")
	private final String exceptionMessage;

	private final Throwable cause;

	public RestError(HttpStatus status, String code, String message, String exceptionMessage, Throwable cause) {

		Assert.notNull(status, "HttpStatus must not be null");

		this.status = status;
		this.code = code;
		this.message = message;
		this.exceptionMessage = exceptionMessage;
		this.cause = cause;
	}

	public HttpStatus getStatus() {
		return status;
	}

	public String getCode() {
		return code;
	}

	public String getMessage() {
		return message;
	}

	public String getExceptionMessage() {
		return exceptionMessage;
	}

	@JsonIgnore
	public Throwable getThrowable() {
		return cause;
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) {
			return true;
		}
		if (o instanceof RestError) {
			RestError e = (RestError) o;
			return Objects.equal(getStatus(), e.getStatus()) && Objects.equal(getCode(), e.getCode())
					&& Objects.equal(getMessage(), e.getMessage())
					&& Objects.equal(getExceptionMessage(), e.getExceptionMessage())
					&& Objects.equal(getThrowable(), e.getThrowable());
		}
		return false;
	}

	@Override
	public int hashCode() {
		return Objects.hashCode(getStatus(), getCode(), getMessage(), getExceptionMessage(), getThrowable());
	}

	@Override
	public String toString() {
		return Objects.toStringHelper(this).add("status", getStatus()).add("code", getCode())
				.add("message", getMessage()).add("exceptionMessage", getExceptionMessage())
				.add("cause", getThrowable()).toString();
	}

	public static class Builder {

		private HttpStatus status;

		private String code;

		private String message;

		private String exceptionMessage;

		private Throwable cause;

		public Builder() {
		}

		public Builder setStatus(int statusCode) {
			this.status = HttpStatus.valueOf(statusCode);
			return this;
		}

		public Builder setStatus(HttpStatus status) {
			this.status = status;
			return this;
		}

		public Builder setCode(String code) {
			this.code = code;
			return this;
		}

		public Builder setMessage(String message) {
			this.message = message;
			return this;
		}

		public Builder setExceptonMessage(String exceptionMessage) {
			this.exceptionMessage = exceptionMessage;
			return this;
		}

		public Builder setThrowable(Throwable cause) {
			this.cause = cause;
			return this;
		}

		public RestError build() {
			if (this.status == null) {
				this.status = HttpStatus.INTERNAL_SERVER_ERROR;
			}
			return new RestError(this.status, this.code, this.message, this.exceptionMessage, this.cause);
		}
	}
}