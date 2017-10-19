package com.lf.admin.handler;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;
import org.springframework.web.filter.GenericFilterBean;
import org.springframework.web.servlet.ModelAndView;

public class ExceptionResolverFilter extends GenericFilterBean {

	private RestHandlerExceptionResolver exceptionResolver;

	@Autowired
	public void setRestHandlerExceptionResolver(RestHandlerExceptionResolver exceptionResolver) {
		Assert.notNull(exceptionResolver);
		this.exceptionResolver = exceptionResolver;
	}

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;

		try {
			chain.doFilter(request, response);
		} catch (IOException ex) {
			throw ex;
		} catch (Exception ex) {
			resolveException(request, response, ex);
		}
	}

	private void resolveException(HttpServletRequest request, HttpServletResponse response, Exception ex)
			throws IOException, ServletException {

		ModelAndView mav = exceptionResolver.resolveException(request, response, null, ex);
		if (mav == null) { // resolved
			return;
		}

		if (ex instanceof ServletException) {
			throw (ServletException) ex;
		} else if (ex instanceof RuntimeException) {
			throw (RuntimeException) ex;
		}

		throw new RuntimeException(ex);
	}
}