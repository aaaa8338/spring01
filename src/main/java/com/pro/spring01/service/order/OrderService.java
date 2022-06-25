package com.pro.spring01.service.order;

import java.util.List;

import com.pro.spring01.model.order.dto.OrderDTO;

public interface OrderService {
	List<OrderDTO> list(String userid);
	void insert(OrderDTO dto); 
	int sumMoney(String userid); 
	List<OrderDTO> detailList(OrderDTO dto);
	List<OrderDTO> adminList();
}
