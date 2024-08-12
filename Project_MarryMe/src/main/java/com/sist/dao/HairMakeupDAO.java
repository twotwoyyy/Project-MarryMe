package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.vo.*;
public class HairMakeupDAO {
	public static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
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
}
