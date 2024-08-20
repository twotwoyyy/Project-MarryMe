package com.sist.dao;

import com.sist.vo.DressVO;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

public class DressDAO {
	private static SqlSessionFactory ssf;
	  static {
		  ssf = CreateSqlSessionFactory.getSsf();
	  }

	  public static List<DressVO> dressListData(Map map) {
		  List<DressVO> list = new ArrayList<DressVO>();
		  SqlSession session = null;
		  try {
			  session = ssf.openSession();
			  list = session.selectList("dressListData", map);
		  } catch (Exception ex) {
			  ex.printStackTrace();
		  } finally {
			  if (session != null)
				  session.close();
		  }
		  return list;
	  }
	  
	  /*
	   *   <select id="dressTotalPage" resultType="int" parameterType="hashmap">
		  	SELECT CEIL(COUNT(*)/12.0) 
		   	FROM dress
		  </select>
	   */
	  public static int dressTotalPage() {
		  int total = 0;
		  SqlSession session = null;
		  try {
			  session = ssf.openSession();
			  total = session.selectOne("dressTotalPage");
		  } catch (Exception ex) {
			  ex.printStackTrace();
		  } finally {
			  if (session != null)
				  session.close();
		  }
		  return total;
	  }
	  
	  public static DressVO dressDetailData(int d_no) {
		  DressVO vo = new DressVO();
		  SqlSession session = null;
		  try {
			  session = ssf.openSession();
			  vo = session.selectOne("dressDetailData", d_no);
		  } catch(Exception ex) {
			  ex.printStackTrace();
		  } finally {
			  if (session != null) {
				  session.close();
			  }
		  }
		  return vo;
	  }
}