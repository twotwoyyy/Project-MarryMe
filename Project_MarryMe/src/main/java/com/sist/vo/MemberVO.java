package com.sist.vo;
/*
ID         NOT NULL VARCHAR2(100) 
PW         NOT NULL VARCHAR2(20)  
NAME       NOT NULL VARCHAR2(51)  
PHONE      NOT NULL VARCHAR2(20)  
EMAIL               VARCHAR2(100) 
POST                VARCHAR2(10)  
ADDRESS1            VARCHAR2(200) 
ADDRESS2            VARCHAR2(100) 
GENDER              VARCHAR2(15)  
WEDDINGDAY          DATE          
ADMIN               CHAR(1)       
REGDATE             DATE   
 */
import java.util.*;

import lombok.Data;
@Data
public class MemberVO {
	private String id, pw, name, phone, email, post, address1, address2, gender, dbwdday, admin, msg;
	private Date weddingday, regdate;
}
