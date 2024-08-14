package com.sist.vo;
/*
 * ID	VARCHAR2(100 BYTE)	No		1	
PW	VARCHAR2(20 BYTE)	No		2	
NAME	VARCHAR2(51 BYTE)	No		3	
PHONE	VARCHAR2(20 BYTE)	No		4	
EMAIL	VARCHAR2(100 BYTE)	Yes		5	
POST	VARCHAR2(10 BYTE)	Yes		6	
ADDRESS1	VARCHAR2(200 BYTE)	Yes		7	
ADDRESS2	VARCHAR2(100 BYTE)	Yes		8	
GENDER	VARCHAR2(15 BYTE)	Yes		9	
WEDDINGDAY	DATE	Yes		10	
ADMIN	CHAR(1 BYTE)	Yes	'n'	11	
 */
import java.util.*;

import lombok.Data;
@Data
public class MemberVO {
	private String id,pw,name,phone,email,post,address1,address2,gender,dbwdday,admin;
	private Date weddingday;
}
