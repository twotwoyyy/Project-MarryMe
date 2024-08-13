package com.sist.vo;
/*
 * NOTICE_NO	NUMBER	No		1	
ID	VARCHAR2(50 BYTE)	No		2	
SUBJECT	VARCHAR2(100 BYTE)	No		3	
REGDATE	DATE	No	SYSDATE 	4	
CONTENT	CLOB	No		5	
HIT	NUMBER	Yes	"0 
"	6	
 */
import java.util.*;

import lombok.Data;
@Data
public class NoticeVO {
	private int no,hit;
	private String subject,content,id,dbday;
	private Date regdate;
}
