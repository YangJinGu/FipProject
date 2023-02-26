package com.icia.web.dao;

import org.springframework.stereotype.Repository;

import com.icia.web.model.User;

@Repository("userDao")
public interface UserDao {
	
	//회원 아이디로 회원정보 가져오기
	public User userSelect(String userId);
	
	//닉네임으로 회원정보 가져오기
	public int userNicknameDuplicateCheck(String userNickname);
	
	//이메일로 회원정보 가져오기
	public int userEmailDuplicateCheck(String userEmail);
	
	//회원가입
	public int userReg(User user);
}
