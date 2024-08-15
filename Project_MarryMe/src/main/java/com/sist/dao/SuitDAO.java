package com.sist.dao;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.vo.SuitVO;

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
	  
	  public static int suitTotalPage(Map map) {
		  int total = 0;
		  SqlSession session = null;
		  try {
			  session = ssf.openSession();
			  total = session.selectOne("suitTotalPage", map);
		  } catch (Exception ex) {
			  ex.printStackTrace();
		  } finally {
			  if (session != null)
				  session.close();
		  }
		  return total;
	  }
	  
	  public static SuitVO suitDetailData(Map map) {
		  SuitVO vo = new SuitVO();
		  SqlSession session = null;
		  try {
			  session = ssf.openSession();
			  session.update("suitHitIncrement", map);
			  session.commit();
			  vo = session.selectOne("suitDetailData", map);
		  } catch(Exception ex) {
			  ex.printStackTrace();
		  } finally {
			  if (session != null)
				  session.close();
		  }
		  return vo;
	  }
}
