package com.sist.vo;

import java.util.Date;

import lombok.Data;

/*
	이름      널?       유형           
	------- -------- ------------ 
	SCNO    NOT NULL NUMBER       
	CNO              NUMBER       
	CATE             NUMBER       
	ID               VARCHAR2(20) 
	REGDATE          DATE         
 */
@Data
public class ScrapVO {
	private int scno,cno,cate;
	private String id,dbday;
	private Date regdate;
}
