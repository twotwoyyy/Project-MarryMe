package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.vo.*;
public class QnaDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
/*
 * <insert id="qnaInsert" parameterType="QnaVO">
 		INSERT INTO qna VALUES((SELECT NVL(MAX(qna_no)+1,1) FROM qna),
 		 #{msg},SYSDATE,#{cate},#{group_id},#{tab},#{id}
 		)
 	</insert>*/
	public static void qnaUserInsert(QnaVO vo) {
		SqlSession session=null;
		try {
		session=ssf.openSession();
		session.insert("qnaUserInsert",vo);
		session.commit();
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}
	

//	<!-- 목록 -->
// 	<select id="qnaListData" resultMap="QnaMap" parameterType="hashmap">
// 		SELECT qna_no,TO_CHAR(regdate,'YYYY-MM-DD'),cate,group_id,tab,name,num
// 		FROM (SELECT qna_no,regdate,cate,group_id,tab,name,rownum as num
// 		FROM (SELECT qna_no,regdate,cate,group_id,tab,name
// 		FROM qna,member 
// 		WHERE qna.id=member.id
// 		ORDER BY group_id))
// 		WHERE num BETWEEN #{start} AND #{end}
// 	</select>
 	
	public static List<QnaVO> qnaUserListData(Map map){
		List<QnaVO> list=new ArrayList<QnaVO>();
		SqlSession session=null;
		try {
		session=ssf.openSession();
		list=session.selectList("qnaUserListData",map);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
		return list;
	}
	public static QnaVO qnaAdminData(Map map) {
		QnaVO vo=new QnaVO();
		SqlSession session=null;
		try {
		session=ssf.openSession();
		vo=session.selectOne("qnaAdminData",map);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
		return vo;
	}
	public static int qnaTotalPage(Map map) {
		int total=0;
		SqlSession session=null;
		try {
		session=ssf.openSession();
		total=session.selectOne("qnaTotalPage",map);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
		return total;
	}
	public static String passwordData(int qno) {
		String pwd="";
		SqlSession session=null;
		try {
		session=ssf.openSession();
		pwd=session.selectOne("passwordData",qno);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
		return pwd;
	}
	public static void qnaUpdate(QnaVO vo) {
		SqlSession session=null;
		try {
		session=ssf.openSession();
		session.update("qnaUpdate",vo);
		session.commit();
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}
	public static void qnaDelete(int qna_no) {
		SqlSession session=null;
		try {
		session=ssf.openSession();
		session.delete("qnaDelete",qna_no);
		session.commit();
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}
	

	public static List<QnaVO> mypageQnaListData(Map map){
		List<QnaVO> list=new ArrayList<QnaVO>();
		SqlSession session=null;
		try {
		session=ssf.openSession();
		list=session.selectList("mypageQnaListData",map);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
		return list;
	}
	public static List<QnaVO> mypageQnaListReData(int group_id){
		List<QnaVO> list=new ArrayList<QnaVO>();
		SqlSession session=null;
		try {
			session=ssf.openSession();
			list=session.selectList("mypageQnaListReData",group_id);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
		return list;
	}

	public static int mypageQnaTotalPage(String id) {
		int total=0;
		SqlSession session=null;
		try {
			session=ssf.openSession();
			total=session.selectOne("mypageQnaTotalPage",id);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally {
			if(session!=null)
				session.close();
		}
		return total;
	}
	public static void mypageQnaDelete(int qna_no) {
		SqlSession session=null;
		try {
			session=ssf.openSession();
			session.delete("mypageQnaDelete",qna_no);
			session.commit();
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}
	public static int getGroupIdCount(int gid) {
		int groupCount=0;
		SqlSession session=null;
		try {
			session=ssf.openSession();
			groupCount=session.selectOne("getGroupIdCount",gid);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally {
			if(session!=null)
				session.close();
		}
		return groupCount;
	}

}
