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
   

//   <!-- 목록 -->
//    <select id="qnaListData" resultMap="QnaMap" parameterType="hashmap">
//       SELECT qna_no,TO_CHAR(regdate,'YYYY-MM-DD'),cate,group_id,tab,name,num
//       FROM (SELECT qna_no,regdate,cate,group_id,tab,name,rownum as num
//       FROM (SELECT qna_no,regdate,cate,group_id,tab,name
//       FROM qna,member 
//       WHERE qna.id=member.id
//       ORDER BY group_id))
//       WHERE num BETWEEN #{start} AND #{end}
//    </select>
    
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
   public static void mypageQnaDelete(int qna_groupid) {
      SqlSession session=null;
      try {
         session=ssf.openSession();
         session.delete("mypageQnaDelete",qna_groupid);
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
   
   // 관리자 페이지 QnA 목록
   public static List<QnaVO> adminQnaListData(Map map){
      List<QnaVO> list = new ArrayList<QnaVO>();
      SqlSession session = null;
      try {
      session = ssf.openSession();
      list = session.selectList("adminQnaListData",map);
      } catch(Exception ex) {
         ex.printStackTrace();
      } finally {
         if (session != null)
            session.close();
      }
      return list;
   }
   
   public static List<QnaVO> adminQnaListReData(int group_id){
      List<QnaVO> list = new ArrayList<QnaVO>();
      SqlSession session = null;
      try {
         session = ssf.openSession();
         list = session.selectList("adminQnaListReData",group_id);
      }catch(Exception ex) {
         ex.printStackTrace();
      }finally {
         if(session!=null)
            session.close();
      }
      return list;
   }
   
   // tab Count로 총 답변 개수를 출력
   public static int getTabCount(int tab) {
      int tabCount = 0;
      SqlSession session=null;
      try {
         session=ssf.openSession();
         tabCount = session.selectOne("getTabCount",tab);
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         if(session!=null)
            session.close();
      }
      return tabCount;
   }
   
   // 관리자 페이지 QnA 총 페이지
   public static int adminQnaTotalPage(String id) {
      int total = 0;
      SqlSession session = null;
      try {
         session = ssf.openSession();
         total = session.selectOne("adminQnaTotalPage",id);
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         if(session != null)
            session.close();
      }
      return total;
   }
   
   // 문의 상세 보기 
	public static QnaVO qnaUpdateData(int no) {
		QnaVO vo = new QnaVO();
		SqlSession session = null;
		try {
			session = ssf.openSession();
//			session.update("noticeHitIncrement",no);
//			session.commit();
			vo = session.selectOne("qnaUpdateData",no);
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return vo;
	}
   
//   // QnA 답변을 출력하는 기능
//   public static void qnaReplyInsert(QnaVO vo) {
//       SqlSession session = null;
//       try {
//           session = ssf.openSession();
//           session.insert("qnaReplyInsert", vo);
//           session.commit();
//       } catch (Exception ex) {
//           ex.printStackTrace();
//       } finally {
//           if (session != null)
//               session.close();
//       }
//   }
	
	public static void adminQnaInsert(QnaVO vo) {
	      SqlSession session = null;
	      try {
	      session = ssf.openSession();
	      session.insert("adminQnaInsert",vo);
	      session.commit();
	      } catch(Exception ex) {
	         ex.printStackTrace();
	      } finally {
	         if (session != null)
	            session.close();
	      }
	   }
	/*
	 * 	 	<select id="adminQnaDetail" parameterType="int" resultType="QnaVO">
		 		SELECT qna_no,msg,TO_CHAR(regdate,'YYYY-MM-DD:HH24:MI:SS') as dbday,cate,group_id,id
		 		FROM qna
		 		WHERE qna_no = #{qna_no}
		 	</select>
	 * 
	 */
	public static QnaVO adminQnaDetail2(int qna_no) {
		
		SqlSession session = null;
		QnaVO vo = new QnaVO();
		System.out.println(777);
		try {
			session = ssf.openSession();

	         vo = session.selectOne("adminQnaDetail2",qna_no);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		System.out.println(vo.getMsg() + "jbGod");
		return vo;
	}
	
}
