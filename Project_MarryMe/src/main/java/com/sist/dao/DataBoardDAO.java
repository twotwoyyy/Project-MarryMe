package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.vo.*;
public class DataBoardDAO {
   private static SqlSessionFactory ssf;
   static
   {
	   ssf=CreateSqlSessionFactory.getSsf();
   }
   // 기능 
   public static void databoardInsert(DataBoardVO vo)
   {
	      SqlSession session=null;
		  try
		  {
			  session=ssf.openSession(true); 
			  session.insert("databoardInsert",vo);
			  
		  }catch(Exception ex)
		  {
			  ex.printStackTrace();
		  }
		  finally
		  {
			  if(session!=null)
				  session.close(); // 반환 (DBCP사용)
		  }
   }
   public static List<DataBoardVO> databoardListData(Map map)
   {
	      List<DataBoardVO> list=new ArrayList<DataBoardVO>();
	      SqlSession session=null;
		  try
		  {
			  session=ssf.openSession(); 
			  list=session.selectList("databoardListData",map);
			  
		  }catch(Exception ex)
		  {
			  ex.printStackTrace();
		  }
		  finally
		  {
			  if(session!=null)
				  session.close(); // 반환 (DBCP사용)
		  }
	   return list;
   }
   public static int databoardRowCount()
   {
	   /*
	    *   SqlSession session=ssf.openSession()
	    *   int count=session.selectOne("databoardRowCount");
	    *   session.close()
	    *   return count;
	    */
	      int count=0;
	      SqlSession session=null;
		  try
		  {
			  session=ssf.openSession(); 
			  count=session.selectOne("databoardRowCount");
			  
		  }catch(Exception ex)
		  {
			  ex.printStackTrace();
		  }
		  finally
		  {
			  if(session!=null)
				  session.close(); // 반환 (DBCP사용)
		  }
	   return count;
   }
   // 상세보기 
   /*
    *   <update id="databoardhitIncrement" parameterType="int">
		     UPDATE project_databoard SET 
		     hit=hit+1
		     WHERE no=#{no}
		   </update>
		   <select id="databoardDetailData" resultType="DataBoardVO" parameterType="int">
		     SELECT no,name,subject,content,
		            TO_CHAR(regdate,'YYYY-MM-DD HH24:MI:SS') as dbday,
		            hit,filename,filesize
		     FROM project_databoard
		     WHERE no=#{no}
		   </select>
    */
   public static DataBoardVO databoardDetailData(int no)
   {
	   DataBoardVO vo=new DataBoardVO();
	   SqlSession session=null;
		  try
		  {
			  session=ssf.openSession(); 
			  
			  session.update("databoardhitIncrement",no);
			  session.commit();//update,delete,insert
			  
			  vo=session.selectOne("databoardDetailData",no);
			  
		  }catch(Exception ex)
		  {
			  ex.printStackTrace();
		  }
		  finally
		  {
			  if(session!=null)
				  session.close(); // 반환 (DBCP사용)
		  }
	   return vo;
   }
   /*
    *   <select id="databoardGetPassword" resultType="string" parameterType="int">
	     SELECT pwd FROM databoard
	     WHERE no=#{no}
	   </select>
	   <select id="databoardFileInfoData" resultType="DataBoardVO" parameterType="int">
	     SELECT filename,filesize 
	     FROM databoard
	     WHERE no=#{no}
	   </select>
	   <delete id="databoardDelete" parameterType="int">
	    DELETE FROM databoard
	    WHERE no=#{no}
	   </delete>
    */
   public static DataBoardVO databoardFileInfoData(int no)
   {
	   // 폴더에서 파일 삭제 
	   DataBoardVO vo=new DataBoardVO();
	   SqlSession session=null;
		  try
		  {
			  session=ssf.openSession(); 
			  vo=session.selectOne("databoardFileInfoData",no);
			  
		  }catch(Exception ex)
		  {
			  ex.printStackTrace();
		  }
		  finally
		  {
			  if(session!=null)
				  session.close(); // 반환 (DBCP사용)
		  }
	   return vo;
   }
   // 실제 삭제 
   /*
    *  <delete id="databoardReplyDelete" parameterType="int">
	    DELETE FROM project_board_reply
	    WHERE bno=#{no}
	   </delete>
    */
   public static String databoardDelete(int no,String pwd)
   {
	   String result="no";
	   SqlSession session=null;
		  try
		  {
			  session=ssf.openSession(); 
			  String db_pwd=session.selectOne("databoardGetPassword",no);
			  if(db_pwd.equals(pwd))
			  {
				  result="yes";
				  session.delete("databoardReplyDelete",no);
				  session.delete("databoardDelete",no);
				  session.commit();
			  }
		  }catch(Exception ex)
		  {
			  ex.printStackTrace();
		  }
		  finally
		  {
			  if(session!=null)
				  session.close(); // 반환 (DBCP사용)
		  }
	   return result;
   }
   
   public static DataBoardVO databoardUpdateData(int no)
   {
	   DataBoardVO vo=new DataBoardVO();
	   SqlSession session=null;
		  try
		  {
			  session=ssf.openSession(); 
			  vo=session.selectOne("databoardDetailData",no);
			  
		  }catch(Exception ex)
		  {
			  ex.printStackTrace();
		  }
		  finally
		  {
			  if(session!=null)
				  session.close(); // 반환 (DBCP사용)
		  }
	   return vo;
   }
   public static String databoardGetPassword(int no)
   {
	   String pwd="";
	   SqlSession session=null;
		  try
		  {
			  session=ssf.openSession(); 
			  pwd=session.selectOne("databoardGetPassword",no);
			  
		  }catch(Exception ex)
		  {
			  ex.printStackTrace();
		  }
		  finally
		  {
			  if(session!=null)
				  session.close(); // 반환 (DBCP사용)
		  }
	   return pwd;
   }
   /*
    *     <update id="databoardUpdate" parameterType="DataBoardVO">
		     UPDATE project_databoard SET
		     name=#{name},subject=#{subject},content=#{content},
		     filename=#{filename},filesize=#{filesize}
		     WHERE no=#{no}
		   </update>
    */
   public static void databoardUpdate(DataBoardVO vo)
   {
	      SqlSession session=null;
		  try
		  {
			  session=ssf.openSession(true); 
			  session.update("databoardUpdate",vo);
			  
		  }catch(Exception ex)
		  {
			  ex.printStackTrace();
		  }
		  finally
		  {
			  if(session!=null)
				  session.close(); // 반환 (DBCP사용)
		  }
   }
   /*
    *   <select id="databoardFindData" resultType="DataBoardVO" parameterType="hashmap">
		    SELECT no,name,subject,TO_CHAR(regdate,'YYYY-MM-DD') as dbday,hit
		    FROM project_databoard
		    WHERE ${fs} LIKE '%'||#{ss}||'%'
		   </select>
    */
   public static List<DataBoardVO> databoardFindData(Map map)
   {
	   List<DataBoardVO> list=new ArrayList<DataBoardVO>();
	   SqlSession session=null;
		  try
		  {
			  session=ssf.openSession(true); 
			  list=session.selectList("databoardFindData",map);
			  
		  }catch(Exception ex)
		  {
			  ex.printStackTrace();
		  }
		  finally
		  {
			  if(session!=null)
				  session.close(); // 반환 (DBCP사용)
		  }
	   return list;
   }
}