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
	public static void qnaInsert(QnaVO vo) {
		SqlSession session=null;
		try {
		session=ssf.openSession();
		session.insert("qnaInsert",vo);
		session.commit();
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}
	
	/*
	<!-- 목록 -->
 	<select id="qnaListData" resultMap="QnaMap" parameterType="hashmap">
 		SELECT qna_no,TO_CHAR(regdate,'YYYY-MM-DD'),cate,group_id,tab,name,num
 		FROM (SELECT qna_no,regdate,cate,group_id,tab,name,rownum as num
 		FROM (SELECT qna_no,regdate,cate,group_id,tab,name
 		FROM qna,member 
 		WHERE qna.id=member.id
 		ORDER BY group_id))
 		WHERE num BETWEEN #{start} AND #{end}
 	</select>
 */
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
}
