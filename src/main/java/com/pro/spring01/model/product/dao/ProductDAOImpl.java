package com.pro.spring01.model.product.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.pro.spring01.model.product.dto.ProductDTO;

@Repository
public class ProductDAOImpl implements ProductDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<ProductDTO> allList(String search_option, String keyword, int start, int end) throws Exception {
		Map <String, Object> map = new HashMap<>();
		map.put("search_option", search_option);
		map.put("keyword", "%"+keyword+"%");
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("product.allList",map);
	}
	
	@Override
	public List<ProductDTO> kindList(String search_option, String keyword, String kind, 
			int start, int end) throws Exception {
		Map <String, Object> map = new HashMap<>();
		map.put("search_option", search_option);
		map.put("keyword", "%"+keyword+"%");
		map.put("kind", kind);
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("product.kindList",map);
	}
	
	@Override
	public int countProduct(String search_option, String keyword) throws Exception {
		Map<String,String> map = new HashMap<>();
        map.put("search_option", search_option);
        map.put("keyword", "%"+keyword+"%");
        return sqlSession.selectOne("product.countProduct",map);
	}
	
	@Override
	public ProductDTO detail(int productid) {
		return sqlSession.selectOne("product.detail",productid);
	}

	@Override
	public void update(ProductDTO dto) {
		sqlSession.update("product.update",dto);

	}

	@Override
	public void delete(int productid) {
		sqlSession.delete("product.delete",productid);

	}

	@Override
	public void insert(ProductDTO dto) {
		sqlSession.insert("product.insert",dto);

	}

	@Override
	public String fileInfo(int productid) {
		return sqlSession.selectOne("product.fileInfo",productid);
	}

	@Override
	public int countProduct1(String search_option, String keyword, String kind) throws Exception {
		Map<String,String> map = new HashMap<>();
        map.put("search_option", search_option);
        map.put("keyword", "%"+keyword+"%");
        map.put("kind", kind);
        return sqlSession.selectOne("product.countProduct1",map);
	}

	@Override
	public int count(String productname) {
		int result = sqlSession.selectOne("product.count",productname);
		return result;
	}

}
