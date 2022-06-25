package com.pro.spring01.service.product;

import java.util.List;

import com.pro.spring01.model.product.dto.ProductDTO;

public interface ProductService {
	public List<ProductDTO> allList(String search_option, String keyword, int start, int end) throws Exception;
	public List<ProductDTO> kindList(String search_option, String keyword, String kind, int start, int end) throws Exception;
	public int countProduct(String search_option, String keyword) throws Exception;
	public int countProduct1(String search_option, String keyword, String kind) throws Exception;
	public ProductDTO detail(int productid);
	public String fileInfo(int productid);
	public void update(ProductDTO dto);
	public void delete(int productid);
	public void insert(ProductDTO dto);
	public int count(String productname);
}
