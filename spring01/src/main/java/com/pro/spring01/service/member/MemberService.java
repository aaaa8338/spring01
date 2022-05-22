package com.pro.spring01.service.member;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.pro.spring01.model.member.dto.MemberDTO;

public interface MemberService {
	
	/**
	 * 회원을 조회한다
	 * @param search_option - 검색옵션
	 * @param keyword - 키워드
	 * @param start - 시작 페이지 
	 * @param end - 마지막 페이지
	 * @return 조회 결과
	 * @exception Exception
	*/
	public List<MemberDTO> list(String search_option, String keyword, int start, int end)throws Exception;
	
	/**
	 * 회원을 등록한다
	 * @param dto - 등록할 정보가 담긴 MemberDto
	 * @return 등록 결과
	 * @exception Exception
	*/
	public void insert(MemberDTO dto);
	public MemberDTO detail(String userid);
	public void delete(String userid);
	public void update(MemberDTO dto);
	public void userUpdate(MemberDTO dto);
	public int idCheck(String userid);
	public boolean pwdCheck(String userid, String userpwd);
	public MemberDTO loginCheck(MemberDTO dto, HttpSession session);
	public MemberDTO loginCheck(MemberDTO dto);
	public void logout(HttpSession session);
	public void changePwd(String userid, String userpwd, String newuserpwd);
	public MemberDTO findPwd(String userid, String email);
	public int countMember(String search_option, String keyword);
	public int count(String userid);
}
