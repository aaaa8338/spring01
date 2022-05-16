package com.pro.spring01.model.order.dao;

import java.util.List;

import com.pro.spring01.model.order.dto.OrderDTO;
import com.pro.spring01.model.order.dto.OrderDetailDTO;

public interface OrderDetailDAO {
	void insertDetail(String userid, String orderid, int cartid);
	void insertDetailed(String userid, String orderid);
	List<OrderDetailDTO> list(OrderDTO dto);
}
