package com.pro.spring01.model.reply.dao;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.pro.spring01.model.reply.dto.ReplyDTO;

public interface ReplyDAO {
	public List<ReplyDTO> list(int bno); //댓글 리스트
    public int count(int bno);            //댓글 수
    public void insert(ReplyDTO dto);    //댓글 작성
    public void update(ReplyDTO dto);
    public void delete(int rno);
}
