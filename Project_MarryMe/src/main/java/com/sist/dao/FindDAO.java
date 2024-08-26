package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.vo.*;
public class FindDAO {
	private static SqlSessionFactory ssf;
	  static {
		  ssf = CreateSqlSessionFactory.getSsf();
	  }
	  
	  public static List<HallVO> findHallListData(String keyword){
		  List<HallVO> list=new ArrayList<HallVO>();
		  SqlSession session=null;
		  try {
			  session=ssf.openSession();
			  list=session.selectList("findHallListData", keyword);
		  }catch(Exception ex) {
			  ex.printStackTrace();
		  }finally {
			  if(session!=null) {
				  session.close();
			  }
		  }
		  return list;
	  }
	  public static List<DressVO> findDressListData(String keyword){
		  List<DressVO> list=new ArrayList<DressVO>();
		  SqlSession session=null;
		  try {
			  session=ssf.openSession();
			  list=session.selectList("findDressListData", keyword);
		  }catch(Exception ex) {
			  ex.printStackTrace();
		  }finally {
			  if(session!=null) {
				  session.close();
			  }
		  }
		  return list;
	  }
	  public static List<SuitVO> findSuitListData(String keyword){
		  List<SuitVO> list=new ArrayList<SuitVO>();
		  SqlSession session=null;
		  try {
			  session=ssf.openSession();
			  list=session.selectList("findSuitListData", keyword);
		  }catch(Exception ex) {
			  ex.printStackTrace();
		  }finally {
			  if(session!=null) {
				  session.close();
			  }
		  }
		  return list;
	  }
	  public static List<StudioVO> findStudioListData(String keyword){
		  List<StudioVO> list=new ArrayList<StudioVO>();
		  SqlSession session=null;
		  try {
			  session=ssf.openSession();
			  list=session.selectList("findStudioListData", keyword);
		  }catch(Exception ex) {
			  ex.printStackTrace();
		  }finally {
			  if(session!=null) {
				  session.close();
			  }
		  }
		  return list;
	  }
	  public static List<HairMakeupVO> findHairMakeupListData(String keyword){
		  List<HairMakeupVO> list=new ArrayList<HairMakeupVO>();
		  SqlSession session=null;
		  try {
			  session=ssf.openSession();
			  list=session.selectList("findHairMakeupListData", keyword);
		  }catch(Exception ex) {
			  ex.printStackTrace();
		  }finally {
			  if(session!=null) {
				  session.close();
			  }
		  }
		  return list;
	  }
	  public static List<GoodsVO> findGoodsListData(String keyword){
		  List<GoodsVO> list=new ArrayList<GoodsVO>();
		  SqlSession session=null;
		  try {
			  session=ssf.openSession();
			  list=session.selectList("findGoodsListData", keyword);
		  }catch(Exception ex) {
			  ex.printStackTrace();
		  }finally {
			  if(session!=null) {
				  session.close();
			  }
		  }
		  return list;
	  }
	  
	  public static int findHallCount(String keyword) {
		  int count=0;
		  SqlSession session=null;
		  try {
			  session=ssf.openSession();
			  String temp=session.selectOne("findHallCount", keyword);
			  if(temp==null) {
				  count=0;
			  }else {
				  count=Integer.parseInt(temp);
			  }
		  }catch(Exception ex) {
			  ex.printStackTrace();
		  }finally {
			  if(session!=null) {
				  session.close();
			  }
		  }
		  return count;
	  }
	  public static int findDressCount(String keyword) {
		  int count=0;
		  SqlSession session=null;
		  try {
			  session=ssf.openSession();
			  String temp=session.selectOne("findDressCount", keyword);
			  if(temp==null) {
				  count=0;
			  }else {
				  count=Integer.parseInt(temp);
			  }
		  }catch(Exception ex) {
			  ex.printStackTrace();
		  }finally {
			  if(session!=null) {
				  session.close();
			  }
		  }
		  return count;
	  }
	  public static int findSuitCount(String keyword) {
		  int count=0;
		  SqlSession session=null;
		  try {
			  session=ssf.openSession();
			  String temp=session.selectOne("findSuitCount", keyword);
			  if(temp==null) {
				  count=0;
			  }else {
				  count=Integer.parseInt(temp);
			  }
		  }catch(Exception ex) {
			  ex.printStackTrace();
		  }finally {
			  if(session!=null) {
				  session.close();
			  }
		  }
		  return count;
	  }
	  public static int findStudioCount(String keyword) {
		  int count=0;
		  SqlSession session=null;
		  try {
			  session=ssf.openSession();
			  String temp=session.selectOne("findStudioCount", keyword);
			  if(temp==null) {
				  count=0;
			  }else {
				  count=Integer.parseInt(temp);
			  }
		  }catch(Exception ex) {
			  ex.printStackTrace();
		  }finally {
			  if(session!=null) {
				  session.close();
			  }
		  }
		  return count;
	  }
	  public static int findHairMakeupCount(String keyword) {
		  int count=0;
		  SqlSession session=null;
		  try {
			  session=ssf.openSession();
			  String temp=session.selectOne("findHairMakeupCount", keyword);
			  if(temp==null) {
				  count=0;
			  }else {
				  count=Integer.parseInt(temp);
			  }
		  }catch(Exception ex) {
			  ex.printStackTrace();
		  }finally {
			  if(session!=null) {
				  session.close();
			  }
		  }
		  return count;
	  }
	  public static int findGoodsCount(String keyword) {
		  int count=0;
		  SqlSession session=null;
		  try {
			  session=ssf.openSession();
			  String temp=session.selectOne("findGoodsCount", keyword);
			  if(temp==null) {
				  count=0;
			  }else {
				  count=Integer.parseInt(temp);
			  }
		  }catch(Exception ex) {
			  ex.printStackTrace();
		  }finally {
			  if(session!=null) {
				  session.close();
			  }
		  }
		  return count;
	  }
	  
}
