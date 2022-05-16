package com.pro.spring01.model.cart.dao;

import java.util.List;

import com.pro.spring01.model.cart.dto.CartDTO;

public interface CartDAO {
	List<CartDTO> money();
	void insert(CartDTO dto); // 장바구니 추가
	List<CartDTO> list(String userid); // 장바구니 목록
	void delete(int cartid); // 장바구니 개별 삭제
	void deleteAll(String userid); // 장바구니 비우기
	void update(CartDTO dto); //장바구니 수정
	int sumMoney(String userid); //장바구니 금액 합계
	int countCart(String userid, int productid); //장바구니 상품 수량
}
