package com.icia.web.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icia.web.dao.UserDao;
import com.icia.web.model.User;

@Service("userService")
public class UserService {
	
	@Autowired
	private UserDao userDao;
	
	private static Logger logger = LoggerFactory.getLogger(UserService.class);
	
	
	//회원정보 검색==================================================================
	
	//회원아이디를 받아와 회원정보 가져와서 User객체로 넘겨준다.
	public User userSelect(String userId) {
		User user = null;								
			
		try {
			user = userDao.userSelect(userId);
		}catch(Exception e) {
			logger.error("[UserService] userSelect Exception", e);
		}
		
		return user;
	}
	
	//이메일로 회원 존재여부 확인
	public int userEmailDuplicateCheck(String userEmail) {
		int count = 0;
		
		try {
			count = userDao.userEmailDuplicateCheck(userEmail);
		}catch(Exception e) {
			logger.error("[UserService] userEmailSelect Exception", e);
		}
		
		return count;
	}
	
	//닉네임으로 회원 존재여부 확인
	public int userNicknameDuplicateCheck(String userNickname) {
		int count = 0;
		
		try {
			count = userDao.userNicknameDuplicateCheck(userNickname);
		}catch(Exception e) {
			logger.error("[UserService] userEmailSelect Exception", e);
		}
		
		return count;
	}
	
	//회원등록
	public int userReg(User user) {
		int count = 0;
		
		try {
			count = userDao.userReg(user);
		}catch(Exception e){
			logger.error("[UserService] userReg Exception", e);
		}
		
		
		return count;
	}
}
