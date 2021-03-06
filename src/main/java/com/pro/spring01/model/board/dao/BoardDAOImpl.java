package com.pro.spring01.model.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.pro.spring01.model.board.dto.BoardDTO;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	SqlSession sqlSession;
	

	@Override
	public void create(BoardDTO dto) throws Exception {
		sqlSession.insert("board.insert",dto);

	}

	@Override
	public BoardDTO read(int bno) throws Exception {
		return sqlSession.selectOne("board.view",bno);
	}

	@Override
	public void update(BoardDTO dto) throws Exception {
		sqlSession.update("board.update",dto);

	}

	@Override
	public void delete(int bno) throws Exception {
		sqlSession.delete("board.delete",bno);

	}

	@Override
	public List<BoardDTO> listAll(int start, int end, String search_option, String keyword) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("search_option", search_option);
		map.put("keyword", "%"+keyword+"%");
		map.put("start", start); // 맵에 자료 저장
		map.put("end", end);
		// mapper에는 2개 이상의 값을 전달할 수 없음(dto 또는 map 사용)

		return sqlSession.selectList("board.list",map);
	}

	@Override
	public void increaseViewcnt(int bno) throws Exception {
		sqlSession.update("board.increaseViewcnt",bno);

	}

	@Override
	public int countArticle(String search_option, String keyword) throws Exception {
		Map<String,String> map=new HashMap<>();
        map.put("search_option", search_option);
        map.put("keyword", "%"+keyword+"%");
        return sqlSession.selectOne("board.countArticle",map);
		
	}

}
