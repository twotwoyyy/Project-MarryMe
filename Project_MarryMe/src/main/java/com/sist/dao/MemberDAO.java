package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import com.sist.vo.*;
public class MemberDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
	
	/*
	<select id="memberIdCheck" resultType="int" parameterType="string">
		SELECT COUNT(*) FROM member WHERE id=#{id}
	</select> 
	*/
	// 아이디 중복 체크
	public static int memberIdCheck(String id) {
		int count=0;
		SqlSession session=null;
		try {
			session=ssf.openSession();
			count=session.selectOne("memberIdCheck", id);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null) {
				session.close();
			}
		}
		return count;
	}
	
	/*
	<insert id="memberInsert" parameterType="MemberVO">
		INSERT INTO member VALUES(#{id}, #{pw}, #{name}, #{phone}, #{email}, #{post}, #{address1}, #{address2}, #{gender}, #{weddingday}, 'n', SYSDATE)
	</insert> 
	 */
	// 신규 가입 (아이디 추가)
	public static void memberInsert(MemberVO vo) {
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			session.insert("memberInsert", vo);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null) {
				session.close();
			}
		}
	}
	
	/*
	<select id="memberLoginData" resultType="MemberVO" parameterType="string">
		SELECT * FROM member WHERE id=#{id}
	</select>
	 */
	public static MemberVO memberLogin(String id, String pw) {
		MemberVO vo=new MemberVO();
		SqlSession session=null;
		try {
			session=ssf.openSession();
			int count=session.selectOne("memberIdCheck", id);
			if(count==0) {
				vo.setMsg("noID");
			}else {
				vo=session.selectOne("memberLoginData", id);
				if(pw.equals(vo.getPw())) {
					vo.setMsg("correct");
				}else {
					vo.setMsg("noPW");
				}
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null) {
				session.close();
			}
		}
		return vo;
	}
	/*
	 *  <select id="memberUpdateData" resultType="MemberVO" parameterType="string">
	 		SELECT id,name,phone,email,post,address1,address2,gender,weddingday
	 		FROM member
	 		WHERE id=#{id}
 		</select>
	 */
	public static MemberVO memberUpdateData(String id) {
		MemberVO vo=new MemberVO();
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			vo=session.selectOne("memberUpdateData",id);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
		return vo;
	}
	
	/*
	<select id="memberIdFindCount" resultType="int" parameterType="MemberVO">
 		SELECT COUNT(*) FROM member WHERE name=#{name} AND email=#{email}
 	</select>
 	<select id="memberIdFindData" resultType="string" parameterType="MemberVO">
 		SELECT RPAD(SUBSTR(id,1,2),LENGTH(id),'*') FROM member
 		WHERE name=#{name} AND email=#{email}
 	</select> 
	 */
	public static String memberIdFind(MemberVO vo) {
		String result="";
		SqlSession session=null;
		try {
			session=ssf.openSession();
			int count=session.selectOne("memberIdFindCount", vo);
			if(count==0) {
				result="incorrect";
			}else {
				result=session.selectOne("memberIdFindData", vo);
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
		return result;
	}
	
	/*
	<select id="memberPwFindCount" resultType="int" parameterType="MemberVO">
 		SELECT COUNT(*) FROM member
 		WHERE id=#{id} AND name=#{name} AND (email=#{email} OR phone=#{phone})
 	</select>
 	<select id="memberPwFindData" resultType="string" parameterType="MemberVO">
 		SELECT pw FROM member
 		WHERE id=#{id} AND name=#{name} AND (email=#{email} OR phone=#{phone})
 	</select  
	 */
	public static String memberPwFind(MemberVO vo) {
		String result="";
		SqlSession session=null;
		try {
			session=ssf.openSession();
			int count=session.selectOne("memberPwFindCount", vo);
			if(count==0) {
				result="incorrect";
			}else {
				result=session.selectOne("memberPwFindData", vo);
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
		return result;
	}
	
	/*
	<select id="memberGetEmail" resultType="string" parameterType="MemberVO">
 		SELECT email FROM member
 		WHERE id=#{id} AND name=#{name} 
 	</select>
	 */
	public static String memberGetEmail(MemberVO vo) {
		String pw_email="";
		SqlSession session=null;
		try {
			session=ssf.openSession();
			pw_email=session.selectOne("memberGetEmail", vo);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
		return pw_email;
	}
	
	
	
	   /*
	    *  <select id="memberGetPassword" resultType="string" parameterType="string">
	          SELECT pw FROM member
	          WHERE id=#{id}
	       </select>
	       <update id="memberUpdate" parameterType="MemberVO">
	          UPDATE member SET
	          name=#{name}, phone=#{phone}, email=#{email},
	          post=#{post}, address1=#{address1}, address2=#{address2}, gender=#{gender}, weddingday=#{weddingday}
	          WHERE id=#{id}
	       </update>
	    */   
      public static boolean memberUpdate(MemberVO vo) {
         boolean bCheck=false;
         SqlSession session=null;
         try {
            session=ssf.openSession();
            String db_pwd=session.selectOne("memberGetPassword",vo.getId());
            
            if(db_pwd != null && db_pwd.equals(vo.getPw())) {
                bCheck=true;
                session.update("memberUpdate", vo);
                session.commit();
            } else {
                bCheck=false;
            }
         }catch(Exception ex) {
            ex.printStackTrace();
         }finally {
            if(session!=null)
               session.close();
         }   
         return bCheck;
      }
      /*
       *<select id="pwCheckData" resultType="int" parameterType="java.util.Map">
			SELECT COUNT(*) FROM member
			WHERE id=#{id} AND pw=#{pw}
		</select>
		<update id="pwChange" parameterType="java.util.Map">
			UPDATE member SET
			pw=#{pw}
			WHERE id=#{id}
		</update>
       */
     // 비밀번호 수정
     // 1-1 비밀번호 확인
	public static int pwCheckData(Map map) {
		int count=0;
		SqlSession session=null;
		try {
			session=ssf.openSession();
			count=session.selectOne("pwCheckData",map);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
		return count;
	}
	// 1-2 비밀번호 업데이트 
	public static void pwChange(Map map) {
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			session.update("pwChange",map);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}
	
	// 회원 탈퇴
	/*
	 * 	<delete id="memberReviewDelete" parameterType="java.util.Map">
		DELETE FROM review
		WHERE id=#{id}
	</delete>
	<delete id="memberReserveDelete" parameterType="java.util.Map">
		DELETE FROM reserve
		WHERE id=#{id}
	</delete>
	<delete id="memberQnaDelete" parameterType="java.util.Map">
		DELETE FROM qna
		WHERE id=#{id}
	</delete>
	<delete id="memberWishDelete" parameterType="java.util.Map">
		DELETE FROM wish_list
		WHERE id=#{id}
	</delete>
	<delete id="memberTotalDelete">
		DELETE FROM member
		WHERE id=#{id}
	</delete>
	 */
	// 회원 탈퇴 
	// 1-1 리뷰 삭제
	public static void memberReviewDelete(String id) {
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			session.delete("memberReviewDelete",id);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}
	// 1-2 예약 삭제
	public static void memberReserveDelete(String id) {
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			session.delete("memberReserveDelete",id);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}
	//1-3 문의 삭제
	public static void memberQnaDelete(String id) {
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			session.delete("memberQnaDelete",id);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}
	// 1-4 위시 삭제
	public static void memberWishDelete(String id) {
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			session.delete("memberWishDelete",id);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}
	// 2-1 최종 탈퇴 
	public static void memberTotalDelete(String id) {
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			session.delete("memberTotalDelete",id);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(session!=null)
				session.close();
		}
	}
	
	/*
	 * 	<select id="memberListData" resultType="MemberVO" parameterType="HashMap">
			SELECT id, name, gender, phone, address1, address2, post, admin, num
			FROM (SELECT id, name, gender, phone, address1, address2, post, admin, rownum as num
			FROM (SELECT id, name, gender, phone, address1, address2, post, admin
			FROM member WHERE name=#{name}
			ORDER BY name ASC))
			WHERE num BETWEEN #{start} AND #{end};
		</select>
	 *
	 */
	public static List<MemberVO> memberListData(Map map) {
		List<MemberVO> list = new ArrayList<MemberVO>();
		SqlSession session = null;
		try {
			session = ssf.openSession();
			list = session.selectList("memberListData", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
	            session.close();
		}
		return list;
	}
}
