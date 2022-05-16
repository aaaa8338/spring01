package com.pro.spring01.service.member;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.pro.spring01.model.member.dto.MemberDTO;

public interface MemberService {
	public List<MemberDTO> list(String search_option, String keyword, int start, int end)throws Exception;
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
