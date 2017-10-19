package com.lf.admin.model;

import java.util.List;

public class ProductOptionDTO {
	private List<Integer> productId;
	private List<Integer> optionId;
	public List<Integer> getProductId() {
		return productId;
	}
	public void setProductId(List<Integer> productId) {
		this.productId = productId;
	}
	public List<Integer> getOptionId() {
		return optionId;
	}
	public void setOptionId(List<Integer> optionId) {
		this.optionId = optionId;
	}
	@Override
	public String toString() {
		return "ProductOptionDTO [productId=" + productId + ", optionId=" + optionId + "]";
	}
	
}
