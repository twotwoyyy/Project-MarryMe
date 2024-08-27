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
	/*	공지 추가
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
		}finally {
			ssfDisconnection(session);
		}
	}
	
	/*	공지 목록
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
		}finally {
			ssfDisconnection(session);
		}
		return list;
	}
	
	// 공지사항 총 개수
	public static int noticeTotal() {
		int total=0;
		SqlSession session=null;
		try {
			session=ssf.openSession();
			
			total=session.selectOne("noticeTotal");
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			ssfDisconnection(session);
		}
		return total;
	}
	
	// 중요 공지사항 (할인, 이벤트, 등)
	public static List<NoticeVO> noticeTop5Data()
    {
    	List<NoticeVO> list=new ArrayList<NoticeVO>();
    	SqlSession session=null;
    	try
    	{
    		session=ssf.openSession(true);
    		list=session.selectList("noticeTop5Data");
    	}catch(Exception ex)
    	{
    		ex.printStackTrace();
    	}
    	finally
    	{
    		if(session!=null)
    			session.close(); //DBCP => 반환 (재사용)
    	}
    	return list;
    }
	
	// 공지 추가
	public static NoticeVO noticeUpdateData(int no)
    {
    	NoticeVO vo=new NoticeVO();
    	SqlSession session=null;
    	try
    	{
    		session=ssf.openSession();
    		vo=session.selectOne("noticeUpdateData",no);
    	}catch(Exception ex)
    	{
    		ex.printStackTrace();
    	}
    	finally
    	{
    		if(session!=null)
    			session.close(); //DBCP => 반환 (재사용)
    	}
    	return vo;
    }
	
	// 공지 수정
	 public static void noticeUpdate(NoticeVO vo)
	    {
	    	SqlSession session=null;
	    	try
	    	{
	    		session=ssf.openSession(true);
	    		session.update("noticeUpdate",vo);
	    	}catch(Exception ex)
	    	{
	    		ex.printStackTrace();
	    	}
	    	finally
	    	{
	    		if(session!=null)
	    			session.close(); //DBCP => 반환 (재사용)
	    	}
	    }
	 
	 // 공지 삭제
	 public static void noticeDelete(int no)
	    {
	    	SqlSession session=null;
	    	try
	    	{
	    		session=ssf.openSession(true);
	    		session.delete("noticeDelete",no);
	    	}catch(Exception ex)
	    	{
	    		ex.printStackTrace();
	    	}
	    	finally
	    	{
	    		if(session!=null)
	    			session.close(); //DBCP => 반환 (재사용)
	    	}
	    }
	 
	 // 잘 모름 왜있는거지..?
	 public static NoticeVO noticeDetilData(int no)
	    {
	    	NoticeVO vo=new NoticeVO();
	    	SqlSession session=null;
	    	try
	    	{
	    		session=ssf.openSession();
	    		session.update("noticeHitIncrement",no);
	    		session.commit();
	    		vo=session.selectOne("noticeUpdateData",no);
	    	}catch(Exception ex)
	    	{
	    		ex.printStackTrace();
	    	}
	    	finally
	    	{
	    		if(session!=null)
	    			session.close(); //DBCP => 반환 (재사용)
	    	}
	    	return vo;
	    }
}
