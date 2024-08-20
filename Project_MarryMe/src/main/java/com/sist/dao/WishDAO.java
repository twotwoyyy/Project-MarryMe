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
			session=ssf.openSession(true);
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
	
}
