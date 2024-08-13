package com.sist.vo;
/*
 * REVIEW_NO	NUMBER	No		1	
IMAGE	VARCHAR2(20 BYTE)	Yes		2	
MSG	CLOB	No		3	
REGDATE	DATE	No	SYSDATE 	4	
PW	VARCHAR2(20 BYTE)	Yes		5	
CATE	NUMBER	No		6	
ID	VARCHAR2(20 BYTE)	No		7	
PNO	NUMBER	No		8	
SCORE	NUMBER	Yes		9	
HIT	NUMBER	Yes	"0 
"	10	
 */
import java.util.*;

import lombok.Data;
@Data
public class ReviewVO {
	private int review_no,cate,pno,score,hit;
	private String image,msg,pw,id,dbday;
	private Date regdate;
}
