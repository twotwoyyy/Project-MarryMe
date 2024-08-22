package com.sist.vo;
import java.util.*;

import lombok.Data;

/*
 *  이름      널?       유형           
	------- -------- ------------ 
	MNO     NOT NULL NUMBER       
	CNO              NUMBER       
	CATE             NUMBER       
	ID               VARCHAR2(20) 
	NAME    NOT NULL VARCHAR2(50) 
	MSG     NOT NULL CLOB         
	REGDATE          DATE         
 */
@Data
public class MemoVO {
	private int mno,cno,cate;
	private String id,name,msg,dbday;
	private Date regdate;
}
