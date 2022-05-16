package com.pro.spring01.model.cart.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.pro.spring01.model.cart.dto.CartDTO;

@Repository
public class CartDAOImpl implements CartDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<CartDTO> money() {
		 return sqlSession.selectList("cart.money");
	}

	@Override
	public void insert(CartDTO dto) {
		sqlSession.insert("cart.insert",dto);

	}

	@Override
	public List<CartDTO> list(String userid) {
		return sqlSession.selectList("cart.list",userid);
	}

	@Override
	public void delete(int cart_id) {
		sqlSession.delete("cart.delete",cart_id);

	}

	@Override
	public void deleteAll(String userid) {
		sqlSession.delete("cart.deleteAll",userid);

	}

	@Override
	public void update(CartDTO dto) {
		sqlSession.update("cart.update",dto);

	}

	@Override
	public int sumMoney(String userid) {
		return sqlSession.selectOne("cart.sumMoney",userid);
	}

	@Override
	public int countCart(String userid, int product_id) {
		// TODO Auto-generated method stub
		return 0;
	}

	

}
