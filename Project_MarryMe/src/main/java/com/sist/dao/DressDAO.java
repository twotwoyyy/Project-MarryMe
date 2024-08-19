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
	  
	  /*
	   * <update id="dressHitIncrement" parameterType="hashmap">
		    UPDATE dress 
		    SET hit = hit + 1
		    WHERE d_no = #{d_no}
		  </update>
		  <select id="dressDetailData" parameterType="hashmap" resultType="DressVO">
		    SELECT * FROM dress
		    WHERE d_no = #{d_no}
		  </select>
	   */
	  public static DressVO dressDetailData(Map map) {
		  DressVO vo = new DressVO();
		  SqlSession session = null;
		  try {
			  session = ssf.openSession();
			  session.update("dressHitIncrement", map);
			  session.commit();
			  vo = session.selectOne("dressDetailData", map);
		  } catch(Exception ex) {
			  ex.printStackTrace();
		  } finally {
			  if (session != null)
				  session.close();
		  }
		  return vo;
	  }
}