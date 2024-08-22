package com.sist.dao;
import java.util.*;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import com.sist.vo.*;
public class WishDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
	
	public static void wishInsert(Map map) {
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			session.insert("wishInsert",map);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}
	// 위시
	public static int wishCheck(Map map) {
		int count=0;
		SqlSession session=null;
		try {
			session=ssf.openSession();
			count=session.selectOne("wishCheck",map);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
		return count;
	}
	
	// 홀 위시 개수
	public static void hallWishCountIncrement(Map map) {
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			session.update("hallWishCountIncrement",map);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}
	// 홀 마이페이지 위시 리스트
	public static List<WishVO> hallWishMypageData(String id){
		List<WishVO> list=new ArrayList<WishVO>();
		SqlSession session=null;
		try {
			session=ssf.openSession();
			list=session.selectList("hallWishMypageData",id);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
		return list;
	}
	
	public static void studioWishCountIncrement(Map map) {
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			session.update("studioWishCountIncrement", map);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}
	public static void hairmakeupWishCountIncrement(Map map) {
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			session.update("hairmakeupWishCountIncrement", map);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}
	
	// 위시 취소하기
	public static void wishCancel(int wno) {
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			session.delete("wishCancel",wno);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}
	
	public static void wishDetailDelete(Map map) {
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			session.delete("wishDetailDelete", map);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}
}
