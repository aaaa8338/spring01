package com.pro.spring01.service.product;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.pro.spring01.model.product.dao.ProductDAO;
import com.pro.spring01.model.product.dto.ProductDTO;


@Service
public class ProductServiceImpl implements ProductService {
	
	@Inject
	ProductDAO productDao;
	
	@Override
	public List<ProductDTO> allList(String search_option, String keyword,int start, int end) throws Exception {
		return productDao.allList(search_option, keyword, start, end);
	}
	
	@Override
	public List<ProductDTO> kindList(String search_option, String keyword, String kind, int start, int end) throws Exception {
		return productDao.kindList(search_option, keyword, kind, start, end);
	}
	
	@Override
	public int countProduct(String search_option, String keyword) throws Exception {
		return productDao.countProduct(search_option, keyword);
	}
	
	@Override
	public ProductDTO detail(int productid) {
		return productDao.detail(productid);
	}

	@Override
	public String fileInfo(int productid) {
		return productDao.fileInfo(productid);
	}

	@Override
	public void update(ProductDTO dto) {
		productDao.update(dto);
	}

	@Override
	public void delete(int productid) {
		productDao.delete(productid);

	}

	@Override
	public void insert(ProductDTO dto) {
		productDao.insert(dto);

	}

	@Override
	public int countProduct1(String search_option, String keyword, String kind) throws Exception {
		return productDao.countProduct1(search_option, keyword, kind);
	}

	@Override
	public int count(String productname) {
		return productDao.count(productname);
	}

	

}
