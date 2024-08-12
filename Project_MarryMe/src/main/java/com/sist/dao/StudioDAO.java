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
}
