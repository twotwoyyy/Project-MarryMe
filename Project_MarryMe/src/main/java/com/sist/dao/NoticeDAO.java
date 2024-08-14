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
	public static void ssfDisconnection(SqlSession session) {
		if(session!=null)
			session.close();
	}
	/*
	 * <insert id="noticeInsert" parameterType="NoticeVO">
		INSERT INTO notice VALUES(
		(SELECT NVL(MAX(notice_no)+1,1) FROM notice),
		#{id},#{subject},SYSDATE,#{content},0
		)
	</insert>
	*/
	public static void noticeInsert(NoticeVO vo) {
		SqlSession session=null;
		try {
			session=ssf.openSession();
			session.insert("noticeInsert",vo);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally {
			ssfDisconnection(session);
		}
	}
	/*
	<!-- JOIN -->
	<resultMap type="com.sist.vo.NoticeVO" id="NoticeMap">
		<result property="mvo.name" column="name"/>
	</resultMap>
	<!-- 조회수 업데이트 -->
	<update id="noticeHitIncrement" parameterType="NoticVO">
		UPDATE notice SET
		hit=hit+1
		WHERE notice_no=#{notice_no}
	</update>
	<select id="noticeListData" resultType="NoticeMap" parameterType="hashmap">
		SELECT notice_no,name,subject,TO_CHAR(regdate,'YYYY-MM-DD'),hit,num
		FROM (SELECT notice_no,name,subject,regdate,hit,rownum as num
		FROM (SELECT notice_no,name,subject,regdate,hit
		FROM notice,member 
		WHERE notice.id=member.id
		ORDER BY notice_no DESC))
		WHERE num BETWEEN #{start} AND #{end}
	</select>
	 */
	public static List<NoticeVO> noticeListData(Map map){
		List<NoticeVO> list=new ArrayList<NoticeVO>();
		SqlSession session=null;
		try {
			session=ssf.openSession();
		//	session.update("noticeHitIncrement",map);
		//	session.commit();
			list=session.selectList("noticeListData",map);
			
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally {
			ssfDisconnection(session);
		}
		return list;
	}
	public static int noticeTotal() {
		int total=0;
		SqlSession session=null;
		try {
			session=ssf.openSession();
			
			total=session.selectOne("noticeTotal");
			
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally {
			ssfDisconnection(session);
		}
		return total;
	}
}
