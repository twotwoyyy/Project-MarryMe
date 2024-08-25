package com.sist.dao;

import com.sist.vo.SuitVO;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

public class SuitDAO {
	private static SqlSessionFactory ssf;
	  static {
		  ssf = CreateSqlSessionFactory.getSsf();
	  }
	  
	  public static List<SuitVO> suitListData(Map map) {
		  List<SuitVO> list = new ArrayList<SuitVO>();
		  SqlSession session = null;
		  try {
			  session = ssf.openSession();
			  list = session.selectList("suitListData", map);
		  } catch (Exception ex) {
			  ex.printStackTrace();
		  } finally {
			  if (session != null)
				  session.close();
		  }
		  return list;
	  }
	  
	  public static int suitTotalPage() {
		  int total = 0;
		  SqlSession session = null;
		  try {
			  session = ssf.openSession();
			  total = session.selectOne("suitTotalPage");
		  } catch (Exception ex) {
			  ex.printStackTrace();
		  } finally {
			  if (session != null)
				  session.close();
		  }
		  return total;
	  }
	  
	  public static SuitVO suitDetailData(int su_no) {
		  SuitVO vo = new SuitVO();
		  SqlSession session = null;
		  try {
			  session = ssf.openSession();
			  vo = session.selectOne("suitDetailData", su_no);
		  } catch(Exception ex) {
			  ex.printStackTrace();
		  } finally {
			  if (session != null)
				  session.close();
		  }
		  return vo;
	  }
}
