package com.pro.spring01.model.order.dao;

import java.util.List;

import com.pro.spring01.model.order.dto.OrderDTO;

public interface OrderDAO {
	List<OrderDTO> list(String userid);
	List<OrderDTO> adminList();
	void insert(OrderDTO dto); 
	int sumMoney(String userid); 
	List<OrderDTO> detailList(OrderDTO dto);
}
