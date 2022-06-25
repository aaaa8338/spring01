package com.pro.spring01.service.order;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.pro.spring01.model.order.dao.OrderDAO;
import com.pro.spring01.model.order.dto.OrderDTO;

@Service
public class OrderServiceImpl implements OrderService {
	@Inject
	OrderDAO orderDao;
		
	@Override
	public List<OrderDTO> list(String userid) {
		return orderDao.list(userid);
	}

	@Override
	public void insert(OrderDTO dto) {
		orderDao.insert(dto);
	}

	@Override
	public int sumMoney(String userid) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<OrderDTO> detailList(OrderDTO dto) {
		return orderDao.detailList(dto);
	}

	@Override
	public List<OrderDTO> adminList() {
		return orderDao.adminList();
	}

}
