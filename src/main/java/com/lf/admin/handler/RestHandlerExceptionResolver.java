package com.lf.admin.handler;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.http.HttpInputMessage;
import org.springframework.http.HttpOutputMessage;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.http.server.ServletServerHttpResponse;
import org.springframework.util.Assert;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.AbstractHandlerExceptionResolver;
import org.springframework.web.util.WebUtils;

import com.google.common.collect.Lists;
import com.lf.admin.json.JsonHttpMessageConverter;

public class RestHandlerExceptionResolver extends AbstractHandlerExceptionResolver implements InitializingBean {

	private static final Logger logger = LoggerFactory.getLogger(RestHandlerExceptionResolver.class);

	private List<HttpMessageConverter<?>> messageConverters = Lists.newArrayList();

	private HttpMessageConverter<?> messageConverter = new JsonHttpMessageConverter();

	private RestErrorResolver restErrorResolver = new DefaultRestErrorResolver();

	/*
	 * Accept 헤더에 관계없이 RestHandlerExceptionResolver 적용할지 여부
	 * 
	 * 기본값: false
	 */
	private boolean forced = true;

	/*
	 * Accept 헤더를 명시하지 않은 경우에 RestHandlerExceptionResolver 적용할지 여부
	 * 
	 * 기본값: false
	 */
	private boolean skipEmptyAccept = false;

	public void setMessageConverter(HttpMessageConverter<?> messageConverter) {
		this.messageConverter = messageConverter;
	}

	public void setRestErrorResolver(RestErrorResolver errorResolver) {
		this.restErrorResolver = errorResolver;
	}

	public void setForced(boolean forced) {
		this.forced = forced;
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		Assert.notNull(messageConverter);
		messageConverters.add(messageConverter);
	}

	@Override
	protected ModelAndView doResolveException(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception ex) {

		ServletWebRequest webRequest = new ServletWebRequest(request, response);

		if (logger.isDebugEnabled())
			ex.printStackTrace();

		try {
			RestError error = restErrorResolver.resolveError(webRequest, handler, ex);
			applyStatusIfPossible(webRequest, error);
			return handleRestError(webRequest, error);
		} catch (Exception handlerException) {
			logger.warn("Handling of [" + ex.getClass().getName() + "] resulted in Exception", handlerException);
		}

		return null;
	}

	private void applyStatusIfPossible(ServletWebRequest webRequest, RestError error) {
		if (!WebUtils.isIncludeRequest(webRequest.getRequest())) {
			webRequest.getResponse().setStatus(error.getStatus().value());
		}
	}

	@Override
	protected boolean shouldApplyTo(HttpServletRequest request, Object handler) {
		if (forced) {
			return true;
		}

		HttpInputMessage inputMessage = new ServletServerHttpRequest(request);
		List<MediaType> acceptedMediaTypes = inputMessage.getHeaders().getAccept();

		if (acceptedMediaTypes.isEmpty()) {
			return !skipEmptyAccept;
		}

		return acceptedMediaTypes.contains(MediaType.APPLICATION_JSON);

	}

	@SuppressWarnings({ "rawtypes", "unchecked", "resource" })
	private ModelAndView handleRestError(ServletWebRequest webRequest, RestError error) throws ServletException,
			IOException {

		HttpInputMessage inputMessage = new ServletServerHttpRequest(webRequest.getRequest());

		List<MediaType> acceptedMediaTypes = inputMessage.getHeaders().getAccept();
		if (forced || (acceptedMediaTypes.isEmpty() && !skipEmptyAccept)) {
			MediaType defaultMediaType = MediaType.APPLICATION_JSON;
			acceptedMediaTypes = Collections.singletonList(defaultMediaType);
		}

		MediaType.sortByQualityValue(acceptedMediaTypes);

		HttpOutputMessage outputMessage = new ServletServerHttpResponse(webRequest.getResponse());

		for (MediaType acceptedMediaType : acceptedMediaTypes) {
			for (HttpMessageConverter messageConverter : messageConverters) {
				if (messageConverter.canWrite(RestError.class, acceptedMediaType)) {
					messageConverter.write(error, acceptedMediaType, outputMessage);
					// return empty model and view to short circuit the
					// iteration and to let
					// Spring know that we've rendered the view ourselves:
					return new ModelAndView();
				}
			}
		}

		logger.warn("Could not find HttpMessageConverter that supports " + acceptedMediaTypes);

		return null;
	}

}
