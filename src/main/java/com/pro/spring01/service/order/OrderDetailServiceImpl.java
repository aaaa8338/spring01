package com.pro.spring01.service.order;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.pro.spring01.model.order.dao.OrderDetailDAO;
import com.pro.spring01.model.order.dto.OrderDTO;
import com.pro.spring01.model.order.dto.OrderDetailDTO;

@Service
public class OrderDetailServiceImpl implements OrderDetailService {
	@Inject
	OrderDetailDAO orderDetailDao;
	
	@Override
	public void insertDetail(String userid, String orderid, int cartid) {
		orderDetailDao.insertDetail(userid,orderid,cartid);
	}

	@Override
	public List<OrderDetailDTO> list(OrderDTO dto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertDetailed(String userid, String orderid) {
		orderDetailDao.insertDetailed(userid,orderid);
		
	}

}
