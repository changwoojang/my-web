package com.lf.admin.service;

import java.util.List;

import com.lf.admin.model.ProductOptionDTO;
import com.lf.admin.model.ProductOptionVO;
import org.springframework.stereotype.Service;

public interface ProductOptionService {
	
	// 데이터를 ProductOptionVO에 맞게 가공하여 리턴한다.
	public List<ProductOptionVO> getProductOptionListByOrder(ProductOptionDTO productOptionDTO);
	// 초기화된 초기 테이블을 리턴하낟.
	public List<ProductOptionVO> getInitializedProductOptionTable();
	
}
