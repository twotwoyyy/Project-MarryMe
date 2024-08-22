package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.vo.*;
public class MemoDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}

	public static void memoInsert(MemoVO vo) {
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			session.insert("memoInsert",vo);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}

	public static List<MemoVO> memoListData(Map map){
		List<MemoVO> list=new ArrayList<MemoVO>();
		SqlSession session=null;
		try {
			session=ssf.openSession();
			list=session.selectList("memoListData",map);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
		return list;
	}
	public static void memoDelete(int rno) {
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			session.delete("memoDelete",rno);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}

	// 업데이트
	public static void memoUpdate(Map map) {
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			session.update("memoUpdate",map);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}
}