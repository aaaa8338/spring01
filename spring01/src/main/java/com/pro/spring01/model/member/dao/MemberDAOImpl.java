package com.pro.spring01.model.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import com.pro.spring01.model.member.dto.MemberDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	@Inject
	SqlSession sqlSession;
	
	@Autowired
	BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Override
	public List<MemberDTO> list(String search_option, String keyword, int start, int end) throws Exception{
		Map <String, Object> map = new HashMap<>();
		map.put("search_option", search_option);
		map.put("keyword", "%"+keyword+"%");
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("member.list",map);
	}

	@Override
	public void insert(MemberDTO dto) {
		sqlSession.insert("member.insert",dto);
	}

	@Override
	public MemberDTO detail(String userid) {
		return sqlSession.selectOne("member.detail",userid);
	}

	@Override
	public void delete(String userid) {
		sqlSession.delete("member.deleted",userid);

	}

	@Override
	public void update(MemberDTO dto) {
		sqlSession.update("member.updated",dto);

	}
	
	@Override
	public void userUpdate(MemberDTO dto) {
		 sqlSession.update("member.userUpdate",dto);
		
	}

	@Override
	public boolean pwdCheck(String userid, String userpwd) {
		
		boolean result = false;
		// mybatis mapper에 전달할 값이 2개 이상인 경우
		// dto 또는 맵으로 전달
		Map<String,String> map = new HashMap<>();
		
		map.put("userid", userid);
		map.put("userpwd", userpwd);
		int count = sqlSession.selectOne("member.pwdCheck", map);
		//레코드가 1개이면 true, 0개이면 false (리턴)
		if(count == 1) {
			result = true;
		}
		return result;
	}

	@Override
	public int idCheck(String userid) {
		int result = sqlSession.selectOne("member.idCheck",userid);
		return result;
	}

	@Override
	public MemberDTO loginCheck(MemberDTO dto) {
		return sqlSession.selectOne("member.loginCheck",dto);
	}

	@Override
	public void changePwd(MemberDTO dto) {
		sqlSession.update("member.changePwd",dto);
	}

	
	@Override
	public MemberDTO findPwd(String userid, String email) {
		Map<String,String> map = new HashMap();
		map.put("userid", userid);
		map.put("email", email);
		MemberDTO memberDto = sqlSession.selectOne("member.findPwd",map);
		return memberDto;
	}

	@Override
	public int countMember(String search_option, String keyword) {
		Map<String,String> map = new HashMap();
		map.put("search_option", search_option);
        map.put("keyword", "%"+keyword+"%");
		return sqlSession.selectOne("member.countMember",map);
	}

	@Override
	public int count(String userid) {
		return 0;
	}

}
