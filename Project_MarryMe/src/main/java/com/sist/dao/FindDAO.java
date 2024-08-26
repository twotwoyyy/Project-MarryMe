package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.vo.*;
public class FindDAO {
	private static SqlSessionFactory ssf;
	  static {
		  ssf = CreateSqlSessionFactory.getSsf();
	  }
	  
	  //<select id="findListData" resultMap="findMap" parameterType="string">
	  public static List<FindVO> findListData(Map map){
		  List<FindVO> list=new ArrayList<FindVO>();
		  SqlSession session=null;
		  try {
			  session=ssf.openSession();
			  list=session.selectList("findListData", map);
		  }catch(Exception ex) {
			  ex.printStackTrace();
		  }finally {
			  if(session!=null) {
				  session.close();
			  }
		  }
		  return list;
	  }
	  
	  public static int findTotalpage(String keyword) {
		  int total=0;
		  SqlSession session=null;
		  try {
			  session=ssf.openSession();
			  total=session.selectOne("findTotalPage", keyword);
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
