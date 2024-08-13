package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.vo.*;
public class StudioDAO {
	public static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
	
	public static List<StudioVO> mainStudioData(){
		List<StudioVO> list=new ArrayList<StudioVO>();
		SqlSession session=null;
		try {
			session=ssf.openSession();
			list=session.selectList("mainStudioData");
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null) {
				session.close();
			}
		}
		return list;
	}
	
	public static List<HairMakeupVO> mainHairMakeupData(){
		List<HairMakeupVO> list=new ArrayList<HairMakeupVO>();
		SqlSession session=null;
		try {
			session=ssf.openSession();
			list=session.selectList("mainHairMakeupData");
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null) {
				session.close();
			}
		}
		return list;
	}
	

	public static List<StudioVO> studioListData(Map map){
		List<StudioVO> list=new ArrayList<StudioVO>();
		SqlSession session=null;
		try {
			session=ssf.openSession();
			list=session.selectList("studioListData", map);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null) {
				session.close();
			}
		}
		return list;
	}
	
	public static int studioTotalPage() {
		int total=0;
		SqlSession session=null;
		try {
			session=ssf.openSession();
			total=session.selectOne("studioTotalPage");
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null) {
				session.close();
			}
		}
		return total;
	}
	
	public static List<HairMakeupVO> hairmakeupListData(Map map){
		List<HairMakeupVO> list=new ArrayList<HairMakeupVO>();
		SqlSession session=null;
		try {
			session=ssf.openSession();
			list=session.selectList("hairmakeupListData", map);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null) {
				session.close();
			}
		}
		return list;
	}
	
	public static int hairmakeupTotalPage() {
		int total=0;
		SqlSession session=null;
		try {
			session=ssf.openSession();
			total=session.selectOne("hairmakeupTotalPage");
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null) {
				session.close();
			}
		}
		return total;
	}
}
