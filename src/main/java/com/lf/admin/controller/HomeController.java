package com.lf.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
//	@Autowired
//	ManagerService managerService;

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(HttpServletRequest request) {
		UserDetails userDetails =  (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		/*
		 * Spring Security 설정으로 생성되는 default 관리자의 경우 DB에 저장되지 않기 때문에 DB에서 가져온 manager가 NULL일 수 있다.
		
		*/
		String userName;
//		Manager manager = managerService.getManagerByLoginId(userDetails.getUsername());
//		if ( manager != null ) {
//			userName = manager.getUserName();
//		} else {
//			userName = userDetails.getUsername();
//		}
		
		HttpSession session = request.getSession();
//        session.setAttribute("username", userName);

		return "home";
	}
}
