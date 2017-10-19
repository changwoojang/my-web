package com.lf.admin.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/error")
public class ErrorPageController {

	@RequestMapping(value = "/access_denied")
	public String handleAccessDenied(HttpServletRequest request) {
		return "error.access_denied";
	}
}
