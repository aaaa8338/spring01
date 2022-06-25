package com.pro.spring01.model.order.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.pro.spring01.model.order.dto.OrderDTO;

@Repository
public class OrderDAOImpl implements OrderDAO {
	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<OrderDTO> list(String userid) {
		return sqlSession.selectList("order.list", userid);
	}

	@Override
	public void insert(OrderDTO dto) {
		sqlSession.insert("order.insert",dto);
	}

	@Override
	public int sumMoney(String userid) {
		return sqlSession.selectOne("order.sumMoney",userid);
	}

	@Override
	public List<OrderDTO> detailList(OrderDTO dto) {
		return sqlSession.selectList("order.detailList",dto);
	}

	@Override
	public List<OrderDTO> adminList() {
		return sqlSession.selectList("order.adminList");
	}

}
