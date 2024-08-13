package com.sist.vo;
/*
 * QNA_NO	NUMBER	No		1	
MSG	CLOB	No		2	
REGDATE	DATE	No	SYSDATE 	3	
CATE	NUMBER	Yes		4	
GROUP_ID	NUMBER	Yes		5	
TAB	NUMBER	Yes		6	
ID	VARCHAR2(50 BYTE)	No		7	
 */
import java.util.*;

import lombok.Data;
@Data
public class QnaVO {
	private int qna_no,cate,tab,group_id;
	private String msg,dbday,id;
	private Date regdate;
}
