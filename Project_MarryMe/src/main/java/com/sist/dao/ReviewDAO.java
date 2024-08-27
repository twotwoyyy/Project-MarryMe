package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.vo.*;
public class ReviewDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
	public static void reviewInsert(ReviewVO vo) {
		SqlSession session=null;
		try {
			session=ssf.openSession();
			session.insert("reviewInsert",vo);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally {
			if(session!=null)
				session.close();
		}
	}
	public static List<ReviewVO> reviewListData(Map map){
		List<ReviewVO> list=new ArrayList<ReviewVO>();
		SqlSession session=null;
		try {
			session=ssf.openSession();
			list=session.selectList("reviewListData",map);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally {
			if(session!=null)
				session.close();
		}
		return list;
	}
	public static List<ReviewVO> mypageReviewListData(Map map){
		List<ReviewVO> list=new ArrayList<ReviewVO>();
		SqlSession session=null;
		try {
			session=ssf.openSession();
			list=session.selectList("mypageReviewListData",map);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally {
			if(session!=null)
				session.close();
		}
		return list;
	}
	public static int reviewTotalPage(Map map) {
		int total=0;
		SqlSession session=null;
		try {
			session=ssf.openSession();
			total=session.selectOne("reviewTotalPage",map);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally {
			if(session!=null)
				session.close();
		}
		return total;
	}
	public static List<Integer> reviewScoreData(Map map) {
		List<Integer> list=new ArrayList<Integer>();
		SqlSession session=null;
		try {
			session=ssf.openSession();
			list=session.selectList("reviewScoreData",map);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally {
			if(session!=null)
				session.close();
		}
		return list;
	}
	public static void reviewUpdate(ReviewVO vo) {
		SqlSession session=null;
		try {
			session=ssf.openSession();
			session.update("reviewUpdate", vo);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally {
			if(session!=null)
				session.close();
		}
	}
	public static String reviewInfo(int rno) {
		String img="";
		SqlSession session=null;
		try {
			session=ssf.openSession();
			img=session.selectOne("reviewInfo", rno);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally {
			if(session!=null)
				session.close();
		}
		return img;
	}
	public static void reviewDelete(int rno) {
		SqlSession session=null;
		try {
			session=ssf.openSession();
			session.delete("reviewDelete", rno);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally {
			if(session!=null)
				session.close();
		}
	}
	public static int mypageTotalPage(String id) {
		int total=0;
		SqlSession session=null;
		try {
			session=ssf.openSession();
			total=session.selectOne("mypageTotalPage",id);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally {
			if(session!=null)
				session.close();
		}
		return total;
	}
}
