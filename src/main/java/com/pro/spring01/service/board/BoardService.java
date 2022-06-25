package com.pro.spring01.service.board;

import java.util.List;

import com.pro.spring01.model.board.dto.BoardDTO;

public interface BoardService {
	public void create(BoardDTO dto) throws Exception; // 글쓰기
	public BoardDTO read(int bno) throws Exception; // 글읽기
	public void update(BoardDTO dto) throws Exception; // 글수정
	public void delete(int bno) throws Exception; // 글삭제
	public List<BoardDTO> listAll(int start, int end, // 목록(페이지 나누기, 검색 기능) 
			String search_option, String keyword) throws Exception;
	public int countArticle(String search_option, String keyword) throws Exception; //레코드 갯수 계산
	public void increaseViewcnt(int bno) throws Exception; // 조회수 증가 처리
	
}
