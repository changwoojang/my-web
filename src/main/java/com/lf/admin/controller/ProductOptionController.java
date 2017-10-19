package com.lf.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lf.admin.model.ProductOptionDTO;
import com.lf.admin.model.ProductOptionVO;
import com.lf.admin.service.ProductOptionService;


@Controller
public class ProductOptionController {

	private final Logger logger = LoggerFactory.getLogger(ProductOptionController.class);


	@Autowired
	public ProductOptionService productOptionSrvc;



	@RequestMapping("/promotion/product-option")
	public String main(HttpServletRequest request) {
		return "promotion.product-option";
	}
	
	@RequestMapping(value = "/promotion/product-option-list", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<ProductOptionVO> getSearchRecommendList(HttpServletRequest request) {
		return productOptionSrvc.getInitializedProductOptionTable();
	}
	
	@RequestMapping(value = "/promotion/product-option/update", method = RequestMethod.GET)
	@ResponseBody
	public List<ProductOptionVO> update(HttpServletRequest request, @ModelAttribute ProductOptionDTO productOptionDTO) {	
		logger.info("{}", productOptionDTO);
		return productOptionSrvc.getProductOptionListByOrder(productOptionDTO);
	}
		
	
}
