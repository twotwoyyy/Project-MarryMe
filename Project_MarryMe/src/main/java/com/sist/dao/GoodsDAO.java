package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.vo.*;
public class GoodsDAO {
	private static SqlSessionFactory ssf;
	private static SqlSession session=null;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
	public static void ssfDisconnection() {
		if(session!=null)
			session.close();
	}
	public static List<GoodsVO> goodsListData(Map map) {
		List<GoodsVO> list=new ArrayList<GoodsVO>();
		
		try {
			session=ssf.openSession();
			list=session.selectList("goodsListData",map);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally {
			ssfDisconnection();
		}
		
		return list;
	}
	public int goodsTotalPage(String category) {
		int total=0;
		try {
			session=ssf.openSession();
			total=session.selectOne("goodsTotalPage",category);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			ssfDisconnection();
		}
		return total;
	}
}
