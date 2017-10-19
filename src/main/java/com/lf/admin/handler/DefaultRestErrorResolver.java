package com.lf.admin.handler;

import java.util.Collections;
import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.ConversionNotSupportedException;
import org.springframework.beans.TypeMismatchException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.MessageSource;
import org.springframework.context.MessageSourceAware;
import org.springframework.http.HttpStatus;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.http.converter.HttpMessageNotWritableException;
import org.springframework.util.Assert;
import org.springframework.util.CollectionUtils;
import org.springframework.web.HttpMediaTypeNotAcceptableException;
import org.springframework.web.HttpMediaTypeNotSupportedException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.ServletRequestBindingException;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.multipart.support.MissingServletRequestPartException;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.i18n.AcceptHeaderLocaleResolver;
import org.springframework.web.servlet.mvc.multiaction.NoSuchRequestHandlingMethodException;

import com.google.common.base.Strings;
import com.google.common.collect.Maps;
import com.lf.admin.exception.AdminException;

public class DefaultRestErrorResolver implements RestErrorResolver, MessageSourceAware, InitializingBean {

	private static final Logger logger = LoggerFactory.getLogger(DefaultRestErrorResolver.class);

	private Map<String, RestError> exceptionMappings = Collections.emptyMap();

	private Map<String, ExceptionMapping> exceptionMappingDefinitions = Collections.emptyMap();

	private MessageSource messageSource;

	private LocaleResolver localeResolver = new AcceptHeaderLocaleResolver();

	public void setMessageSource(MessageSource messageSource) {
		this.messageSource = messageSource;
	}

	public void setLocaleResolver(LocaleResolver resolver) {
		this.localeResolver = resolver;
	}

	public void setExceptionMappingDefinitions(Properties mappings) {

		Assert.notNull(mappings);

		Map<String, ExceptionMapping> exceptionMappings = new LinkedHashMap<String, ExceptionMapping>();
		for (Enumeration<?> names = mappings.propertyNames(); names.hasMoreElements();) {
			String exception = (String) names.nextElement();
			String mapping = mappings.getProperty(exception);
			exceptionMappings.put(exception, ExceptionMapping.parse(mapping));
		}
		this.exceptionMappingDefinitions = exceptionMappings;
	}

	@Override
	public void afterPropertiesSet() throws Exception {

		Map<String, ExceptionMapping> definitions = createDefaultExceptionMappingDefinitions();

		if (!CollectionUtils.isEmpty(this.exceptionMappingDefinitions)) {
			definitions.putAll(this.exceptionMappingDefinitions);
		}

		this.exceptionMappings = toRestErrors(definitions);
	}

	protected final Map<String, ExceptionMapping> createDefaultExceptionMappingDefinitions() {

		Map<String, ExceptionMapping> mappings = Maps.newLinkedHashMap();

		// C0101 : 400 : 요청 오류 - 입력 오류
		final ExceptionMapping INPUT_ERROR = ExceptionMapping.with("C0101", HttpStatus.BAD_REQUEST);
		applyDef(mappings, HttpMessageNotReadableException.class, INPUT_ERROR);
		applyDef(mappings, MissingServletRequestParameterException.class, INPUT_ERROR);
		applyDef(mappings, MissingServletRequestPartException.class, INPUT_ERROR);
		applyDef(mappings, ServletRequestBindingException.class, INPUT_ERROR);
		applyDef(mappings, MethodArgumentNotValidException.class, INPUT_ERROR);
		applyDef(mappings, TypeMismatchException.class, INPUT_ERROR);

		// C0102 : 406 : 요청 오류 - 미지원 응답 포맷 (Accept 헤더에 지원되지 않는 Content-Type 명시)
		applyDef(mappings, HttpMediaTypeNotAcceptableException.class,
				ExceptionMapping.with("C0102", HttpStatus.NOT_ACCEPTABLE));

		// C0103 : 415 : 요청 오류 - 미지원 요청 포맷 (PUT/POST시 Content-Type 헤더에 지원되지 않는
		// 타입 명시)
		applyDef(mappings, HttpMediaTypeNotSupportedException.class,
				ExceptionMapping.with("C0103", HttpStatus.UNSUPPORTED_MEDIA_TYPE));

		// C0104 : 404 : 요청 오류 - 요청한 자원이 존재하지 않는 경우
		applyDef(mappings, NoSuchRequestHandlingMethodException.class,
				ExceptionMapping.with("C0104", HttpStatus.NOT_FOUND));

		// C0105 : 405 : 요청 오류 - 지원되지 않는 HTTP method
		applyDef(mappings, HttpRequestMethodNotSupportedException.class,
				ExceptionMapping.with("C0105", HttpStatus.METHOD_NOT_ALLOWED));

		// C9901 : 500 : 서버 설정 오류
		final ExceptionMapping SERVER_SETTING_ERROR = ExceptionMapping.with("C9901", HttpStatus.INTERNAL_SERVER_ERROR);
		applyDef(mappings, HttpMessageNotWritableException.class, SERVER_SETTING_ERROR);
		applyDef(mappings, ConversionNotSupportedException.class, SERVER_SETTING_ERROR);

		return mappings;
	}

	@SuppressWarnings("rawtypes")
	private void applyDef(Map<String, ExceptionMapping> m, Class clazz, ExceptionMapping mapping) {
		applyDef(m, clazz.getName(), mapping);
	}

	private void applyDef(Map<String, ExceptionMapping> m, String key, ExceptionMapping mapping) {
		m.put(key, mapping);
	}

	@Override
	public RestError resolveError(ServletWebRequest request, Object handler, Exception ex) {

		RestError template = getRestErrorTemplate(ex);

		if (template == null) {
			// C9999 : 500 : 서버 오류 - 미분류 서버 오류
			template = toRestError(ExceptionMapping.with("C9999", HttpStatus.INTERNAL_SERVER_ERROR));
		}

		RestError.Builder builder = new RestError.Builder();

		builder.setStatus(getStatusValue(template, request, ex));
		builder.setCode(getCode(template, request, ex));
		builder.setMessage(getMessage(template, request, ex));
		builder.setExceptonMessage(getExceptionMessage(template, request, ex));
		builder.setThrowable(ex);

		return builder.build();
	}

	protected int getStatusValue(RestError template, ServletWebRequest request, Exception ex) {
		return template.getStatus().value();
	}

	protected String getCode(RestError template, ServletWebRequest request, Exception ex) {
		return template.getCode();
	}

	protected String getMessage(RestError template, ServletWebRequest request, Exception ex) {

		String message = template.getStatus().getReasonPhrase();

		if (messageSource != null) {
			Locale locale = null;
			if (localeResolver != null) {
				locale = localeResolver.resolveLocale(request.getRequest());
			}
			message = messageSource.getMessage(template.getCode(), null /* args */, message, locale);
		}

		return message;
	}

	protected String getExceptionMessage(RestError template, ServletWebRequest request, Exception ex) {
		return ex.toString();
	}

	private RestError getRestErrorTemplate(Exception ex) {

		Map<String, RestError> mappings = this.exceptionMappings;

		if (ex instanceof AdminException) {
			AdminException ae = (AdminException) ex;
			if (!Strings.isNullOrEmpty(ae.getCode())) {
				RestError.Builder builder = new RestError.Builder();
				builder.setCode(ae.getCode());
				builder.setStatus(HttpStatus.INTERNAL_SERVER_ERROR);
				return builder.build();
			}
		}

		if (CollectionUtils.isEmpty(mappings)) {
			return null;
		}

		RestError template = null;
		String dominantMapping = null;
		int deepest = Integer.MAX_VALUE;

		for (Map.Entry<String, RestError> entry : mappings.entrySet()) {
			String key = entry.getKey();
			int depth = getDepth(key, ex);
			if (depth >= 0 && depth < deepest) {
				deepest = depth;
				dominantMapping = key;
				template = entry.getValue();
			}
		}

		if (template != null) {
			logger.debug("get RestError template '" + template + "' for exception of type [" + ex.getClass().getName()
					+ "], based on exception mapping [" + dominantMapping + "]");
		}

		return template;
	}

	protected int getDepth(String exceptionMapping, Exception ex) {
		return getDepth(exceptionMapping, ex.getClass(), 0);
	}

	@SuppressWarnings("rawtypes")
	private int getDepth(String exceptionMapping, Class exceptionClass, int depth) {
		if (exceptionClass.getName().contains(exceptionMapping)) {
			// Found it!
			return depth;
		}
		// If we've gone as far as we can go and haven't found it...
		if (exceptionClass.equals(Throwable.class)) {
			return -1;
		}
		return getDepth(exceptionMapping, exceptionClass.getSuperclass(), depth + 1);
	}

	protected Map<String, RestError> toRestErrors(Map<String, ExceptionMapping> mappings) {

		if (CollectionUtils.isEmpty(mappings)) {
			return Collections.emptyMap();
		}

		Map<String, RestError> exceptionMappings = Maps.newLinkedHashMap();

		for (Map.Entry<String, ExceptionMapping> entry : mappings.entrySet()) {
			String key = entry.getKey();
			ExceptionMapping value = entry.getValue();
			RestError template = toRestError(value);
			exceptionMappings.put(key, template);
		}

		return exceptionMappings;
	}

	protected RestError toRestError(ExceptionMapping exceptionMapping) {

		Assert.notNull(exceptionMapping, "exception mapping must not be null");

		RestError.Builder builder = new RestError.Builder();

		builder.setCode(exceptionMapping.getCode());
		builder.setStatus(exceptionMapping.getStatus().value());

		return builder.build();
	}

	public static class ExceptionMapping {

		private final String code;

		private final HttpStatus status;

		public ExceptionMapping(String code, HttpStatus status) {
			this.code = code;
			this.status = status;
		}

		public String getCode() {
			return code;
		}

		public HttpStatus getStatus() {
			return status;
		}

		public static ExceptionMapping with(String code, HttpStatus status) {
			return new ExceptionMapping(code, status);
		}

		public static ExceptionMapping parse(String entry) {
			// delimit by space, tab, newline, or comma
			String[] arr = entry.split("[\\s,]+");
			if (arr.length != 2) {
				throw new IllegalArgumentException("Invalid Exception Mapping Entry: value=" + entry);
			}
			String code = arr[0];
			HttpStatus status = HttpStatus.valueOf(Integer.parseInt(arr[1]));

			return with(code, status);
		}
	}
}
