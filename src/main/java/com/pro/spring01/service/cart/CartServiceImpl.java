package com.pro.spring01.service.cart;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.pro.spring01.model.cart.dao.CartDAO;
import com.pro.spring01.model.cart.dto.CartDTO;

@Service
public class CartServiceImpl implements CartService {
	@Inject
	CartDAO cartDao;
	
	@Override
	public List<CartDTO> money() {
		return cartDao.money();
	}

	@Override
	public void insert(CartDTO dto) {
		cartDao.insert(dto);
	}

	@Override
	public List<CartDTO> list(String userid) {
		return cartDao.list(userid);
	}

	@Override
	public void delete(int cartid) {
		cartDao.delete(cartid);
	}

	@Override
	public void deleteAll(String userid) {
		cartDao.deleteAll(userid);
	}

	@Override
	public void update(CartDTO dto) {
		cartDao.update(dto);

	}

	@Override
	public int sumMoney(String userid) {
		return cartDao.sumMoney(userid);
	}

	@Override
	public int countCart(String userid, int productid) {
		// TODO Auto-generated method stub
		return 0;
	}

}
