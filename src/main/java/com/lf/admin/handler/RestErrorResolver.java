package com.lf.admin.handler;

import org.springframework.web.context.request.ServletWebRequest;

public interface RestErrorResolver {

	public RestError resolveError(ServletWebRequest request, Object handler, Exception ex);
}
