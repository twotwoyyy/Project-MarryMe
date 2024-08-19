package com.sist.dao;
import java.util.*;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import com.sist.vo.*;
public class ScrapDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
	public static void scrapInsert(Map map) {
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			session.insert("scrapInsert",map);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}
	// 스크랩
	public static int scrapCheck(Map map) {
		int count=0;
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			count=session.selectOne("scrapCheck",map);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
		return count;
	}
	// 홀 스크랩 개수
	public static void hallScrapCountIncrement(Map map) {
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			session.update("hallScrapCountIncrement",map);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}
	
}
