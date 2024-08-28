package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.vo.*;
public class NoticeDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
	// 공지 목록 
	public static List<NoticeVO> noticeListData(Map map){
		List<NoticeVO> list=new ArrayList<NoticeVO>();
		SqlSession session=null;
		try {
			session=ssf.openSession();
			list=session.selectList("noticeListData",map);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
		return list;
	}
	
	// 공지 추가
	public static void noticeInsert(NoticeVO vo) {
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			session.insert("noticeInsert",vo);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}
	
	// 공지 총 개수 읽기 
	public static int noticeRowCount() {
		int count=0;
		SqlSession session=null;
		try {
			session=ssf.openSession();
			count=session.selectOne("noticeRowCount");
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
		return count;
	}
	
	// 공지사항 최신순 출력 
	public static List<NoticeVO> noticeTop5Data() {
		List<NoticeVO> list=new ArrayList<NoticeVO>();
		SqlSession session=null;
		try {
			session=ssf.openSession();
			list=session.selectList("noticeTop5Data");
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
		return list;
	}
	
	// 공지사항 수정
	// 1-1 데이터 받기
	public static NoticeVO noticeUpdateData(int no) {
		NoticeVO vo=new NoticeVO();
		SqlSession session=null;
		try {
			session=ssf.openSession();
			vo=session.selectOne("noticeUpdateData",no);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
		return vo;
	}
	
	// 1-2 수정하기
	public static void noticeUpdate(NoticeVO vo) {
		SqlSession session=null;
		try {
			session=ssf.openSession();
			session.update("noticeUpdate",vo);
			session.commit();
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}
	
	// 공지사항 삭제
	public static void noticeDelete(int no) {
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			session.delete("noticeDelete",no);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}
	
	// 공지 상세 
	public static NoticeVO noticeDetailData(int no) {
		NoticeVO vo=new NoticeVO();
		SqlSession session=null;
		try {
			session=ssf.openSession();
			session.update("noticeHitIncrement",no);
			session.commit();
			vo=session.selectOne("noticeUpdateData",no);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
		return vo;
	}
}
