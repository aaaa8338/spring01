package com.pro.spring01.model.reply.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.pro.spring01.model.reply.dto.ReplyDTO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {
	
	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<ReplyDTO> list(int bno) {
		return sqlSession.selectList("reply.list",bno);
	}
	
	@Override
	public int count(int bno) {
		return sqlSession.selectOne("reply.count",bno);
	}

	@Override
	public void insert(ReplyDTO dto) {
		sqlSession.insert("reply.insert",dto);
	}

	@Override
	public void update(ReplyDTO dto) {
		sqlSession.update("reply.update", dto);
	}

	@Override
	public void delete(int rno) {
		sqlSession.delete("reply.delete", rno);
	}



}
