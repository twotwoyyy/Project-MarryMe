package com.sist.dao;

import com.sist.vo.DressVO;
import com.sist.vo.StudioVO;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

public class DressDAO {
	private static SqlSessionFactory ssf;
	  static {
		  ssf = CreateSqlSessionFactory.getSsf();
	  }
	  
	  // 드레스 메인
	  public static List<DressVO> mainDressData(){
			List<DressVO> list = new ArrayList<DressVO>();
			SqlSession session = null;
			try {
				session = ssf.openSession();
				list = session.selectList("mainDressData");
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				if (session != null) {
					session.close();
				}
			}
			return list;
		}
	  
	  // 드레스 목록
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
	  
	  // 드레스 총 페이지
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
	  
	  // 드레스 상세보기
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