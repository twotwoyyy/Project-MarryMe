package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.vo.*;
public class GoodsDAO {
	private static SqlSessionFactory ssf;	
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
	public static void ssfDisconnection(SqlSession session) {
		if(session!=null)
			session.close();
	}
	public static List<GoodsVO> mainGoodsData(String cate){
		List<GoodsVO> list=new ArrayList<GoodsVO>();
		SqlSession session=null;
		try {
			
			session=ssf.openSession();
			list=session.selectList("mainGoodsData",cate);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			ssfDisconnection(session);
		}
		
		return list;
	}
	public static List<GoodsVO> goodsListData(Map map) {
		List<GoodsVO> list=new ArrayList<GoodsVO>();
		SqlSession session=null;
		try {
			
			session=ssf.openSession();
			list=session.selectList("goodsListData",map);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally {
			ssfDisconnection(session);
		}
		
		return list;
	}
	public static int goodsTotalPage(Map map) {
		int total=0;
		SqlSession session=null;
		try {
			session=ssf.openSession();
			total=session.selectOne("goodsTotalPage",map);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			ssfDisconnection(session);
		}
		return total;
	}
}
