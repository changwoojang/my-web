package com.lf.admin.filter;
 
import java.io.IOException;

import nl.captcha.Captcha;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.filter.GenericFilterBean;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

 
public class RefererFilter extends GenericFilterBean  {
	private static final Logger logger = LoggerFactory.getLogger(RefererFilter.class);
	
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
    	
    	HttpServletRequest request = (HttpServletRequest) req;
    	HttpServletResponse response = (HttpServletResponse) res;
        try{
	    
	    	chain.doFilter(req, res);
       }catch(IllegalStateException e){
    	   logger.info("ERROR: Login() : Wrong User Information");
       }
    }
}