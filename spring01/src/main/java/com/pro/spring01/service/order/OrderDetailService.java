package com.pro.spring01.service.order;

import java.util.List;

import com.pro.spring01.model.order.dto.OrderDTO;
import com.pro.spring01.model.order.dto.OrderDetailDTO;

public interface OrderDetailService {
	void insertDetail(String userid, String orderid, int cartid);
	void insertDetailed(String userid, String orderid);
	List<OrderDetailDTO> list(OrderDTO dto);
}
