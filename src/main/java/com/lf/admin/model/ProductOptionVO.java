package com.lf.admin.model;

import java.util.List;

public class ProductOptionVO {
	
	private int productId;
	private int optionId;
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public int getOptionId() {
		return optionId;
	}
	public void setOptionId(int optionId) {
		this.optionId = optionId;
	}
	@Override
	public String toString() {
		return "ProductOptionVO [productId=" + productId + ", optionId=" + optionId + "]";
	}
}
