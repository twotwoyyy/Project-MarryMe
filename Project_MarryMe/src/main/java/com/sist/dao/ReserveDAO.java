package com.sist.dao;
import java.util.*;
import com.sist.vo.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
public class ReserveDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
	
	public static int reserveCheck(ReserveVO vo) {
		int count=0;
		SqlSession session=null;
		try {
			session=ssf.openSession();
			count=session.selectOne("reserveCheck", vo);
		}catch(Exception ex) {
			
		}finally {
			if(session!=null) {
				session.close();
			}
		}
		return count;
	}
	
	public static void reserveInsert(ReserveVO vo) {
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			session.insert("reserveInsert", vo);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null) {
				session.close();
			}
		}
	}
	
	public static List<ReserveVO> reserveExist(Map map) {
		List<ReserveVO> list=new ArrayList<ReserveVO>();
		SqlSession session=null;
		try {
			session=ssf.openSession();
			list=session.selectList("reserveExist", map);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null) {
				session.close();
			}
		}
		return list;
	}
}