package com.pro.spring01.service.cart;

import java.util.List;

import com.pro.spring01.model.cart.dto.CartDTO;

public interface CartService {
	List<CartDTO> money();
	void insert(CartDTO dto);
	List<CartDTO> list(String userid); 
	void delete(int cartid); 
	void deleteAll(String userid); 
	void update(CartDTO dto); 
	int sumMoney(String userid); 
	int countCart(String userid, int productid); 
}
