package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import com.sist.vo.*;
public class MemberDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
	
	/*
	<select id="memberIdCheck" resultType="int" parameterType="string">
		SELECT COUNT(*) FROM member WHERE id=#{id}
	</select> 
	*/
	public static int memberIdCheck(String id) {
		int count=0;
		SqlSession session=null;
		try {
			session=ssf.openSession();
			count=session.selectOne("memberIdCheck", id);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null) {
				session.close();
			}
		}
		return count;
	}
	
	/*
	<insert id="memberInsert" parameterType="MemberVO">
		INSERT INTO member VALUES(#{id}, #{pw}, #{name}, #{phone}, #{email}, #{post}, #{address1}, #{address2}, #{gender}, #{weddingday}, 'n', SYSDATE)
	</insert> 
	 */
	public static void memberInsert(MemberVO vo) {
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			session.insert("memberInsert", vo);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null) {
				session.close();
			}
		}
	}
	
	/*
	<select id="memberLoginData" resultType="MemberVO" parameterType="string">
		SELECT * FROM member WHERE id=#{id}
	</select>
	 */
	public static MemberVO memberLogin(String id, String pw) {
		MemberVO vo=new MemberVO();
		SqlSession session=null;
		try {
			session=ssf.openSession();
			int count=session.selectOne("memberIdCheck", id);
			if(count==0) {
				vo.setMsg("noID");
			}else {
				vo=session.selectOne("memberLoginData", id);
				if(pw.equals(vo.getPw())) {
					vo.setMsg("correct");
				}else {
					vo.setMsg("noPW");
				}
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null) {
				session.close();
			}
		}
		return vo;
	}
}
