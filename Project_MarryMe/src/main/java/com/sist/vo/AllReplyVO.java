package com.sist.vo;
/*
 *   RNO     NOT NULL NUMBER       
CNO              NUMBER       
TYPE             NUMBER       
ID               VARCHAR2(20) 
NAME    NOT NULL VARCHAR2(50) 
MSG     NOT NULL CLOB         
REGDATE          DATE    
 */
import java.util.*;

import lombok.Data;

@Data
public class AllReplyVO {
   private int rno,cno,type;
   private String id,name,msg,dbday;
   private Date regdate;
}