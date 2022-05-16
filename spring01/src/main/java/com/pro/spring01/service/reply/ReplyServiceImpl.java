package com.pro.spring01.service.reply;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.pro.spring01.model.reply.dao.ReplyDAO;
import com.pro.spring01.model.reply.dto.ReplyDTO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Inject
	ReplyDAO replyDao; 
	
	@Override
	public List<ReplyDTO> list(int bno) {
		return replyDao.list(bno);
	}

	@Override
	public int count(int bno) {
		return replyDao.count(bno);
	}

	@Override
	public void insert(ReplyDTO dto) {
		replyDao.insert(dto);

	}

	@Override
	public void update(ReplyDTO dto) {
		replyDao.update(dto);
		
	}

	@Override
	public void delete(int rno) {
		replyDao.delete(rno);
	}

}
