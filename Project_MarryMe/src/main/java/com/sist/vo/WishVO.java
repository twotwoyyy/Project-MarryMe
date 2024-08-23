package com.sist.vo;

import java.util.Date;

import lombok.Data;

/*
	이름      널?       유형           
	------- -------- ------------ 
	WNO    NOT NULL NUMBER       
	CNO              NUMBER       
	CATE             NUMBER       
	ID               VARCHAR2(20) 
	REGDATE          DATE         
 */
@Data
public class WishVO {
	private int wno,cno,cate;
	private String id,dbday;
	private Date regdate;
	HallVO hvo=new HallVO();
	StudioVO svo=new StudioVO();
	HairMakeupVO mvo=new HairMakeupVO();
}
