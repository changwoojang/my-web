package com.lf.admin.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import com.lf.admin.model.ProductOptionDTO;
import com.lf.admin.model.ProductOptionVO;
import org.springframework.stereotype.Service;

@Service
public class ProductOptionServiceImpl implements ProductOptionService{

	@Override
	public List<ProductOptionVO> getProductOptionListByOrder(ProductOptionDTO productOptionDTO) {
		int i =0 ;
		List<ProductOptionVO> productOptionList = new ArrayList<>();
		
		//productOPtionVO 기준으로 데이터 가공 
		for(int each : productOptionDTO.getProductId()){
			ProductOptionVO productOptionVO = new ProductOptionVO();
			productOptionVO.setProductId(each);
			productOptionVO.setOptionId(productOptionDTO.getOptionId().get(i));
			productOptionList.add(productOptionVO);
			i++;
		}
		
		//ProductID 기준으로 sorting
		Collections.sort(productOptionList, new Comparator<ProductOptionVO>(){
			public int compare(ProductOptionVO o1, ProductOptionVO o2)
			{
			     return Integer.compare(o1.getProductId(),o2.getProductId());
			}
		});
		 return productOptionList;
	}

	@Override
	public List<ProductOptionVO> getInitializedProductOptionTable() {
		List<ProductOptionVO> productOptionList = new ArrayList<>();
		
		//첫 테이블 초기화
		ProductOptionVO productOptionVO = new ProductOptionVO();	
		productOptionVO.setProductId(0);
		productOptionVO.setOptionId(0);
		
		for(int i = 0 ; i < 10; i++)
			productOptionList.add(productOptionVO);
		
		return productOptionList;
	}

}
