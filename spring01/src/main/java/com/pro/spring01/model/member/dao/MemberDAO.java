package com.pro.spring01.model.member.dao;

import java.util.List;

import com.pro.spring01.model.member.dto.MemberDTO;

public interface MemberDAO {
	public List<MemberDTO> list(String search_option, String keyword, int start, int end) throws Exception;
	public void insert(MemberDTO dto);
	public MemberDTO detail(String userid);
	public void delete(String userid);
	public void update(MemberDTO dto);
	public void userUpdate(MemberDTO dto);
	public boolean pwdCheck(String userid, String userpwd);
	public int idCheck(String userid);
	public MemberDTO loginCheck(MemberDTO dto);
	public void changePwd(MemberDTO dto);
	public MemberDTO findPwd(String userid, String email);
	public int countMember(String search_option, String keyword);
	public int count(String userid);
}
