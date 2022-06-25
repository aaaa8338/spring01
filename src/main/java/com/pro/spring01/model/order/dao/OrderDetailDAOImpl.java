package com.pro.spring01.model.order.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.pro.spring01.model.order.dto.OrderDTO;
import com.pro.spring01.model.order.dto.OrderDetailDTO;

@Repository
public class OrderDetailDAOImpl implements OrderDetailDAO {
	@Inject
	SqlSession sqlSession; 
	
	@Override
	public void insertDetail(String userid, String orderid, int cartid) {
		Map<String,Object> map = new HashMap();
		map.put("orderid", orderid);
		map.put("cartid", cartid);
		map.put("userid", userid);
		sqlSession.update("orderDetail.insert",map);
	}

	@Override
	public List<OrderDetailDTO> list(OrderDTO dto) {
		return null;
	}

	@Override
	public void insertDetailed(String userid, String orderid) {
		Map<String,Object> map = new HashMap();
		map.put("orderid", orderid);
		map.put("userid", userid);
		sqlSession.update("orderDetail.inserted",map);
		
	}

}
