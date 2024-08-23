package com.sist.vo;
/*
RESNO   NOT NULL NUMBER       
ID               VARCHAR2(20) 
PNO              NUMBER       
RDATE   NOT NULL VARCHAR2(20) 
RTIME   NOT NULL VARCHAR2(20) 
CATE             NUMBER       
REGDATE          DATE         
CONFIRM          CHAR(1) 
 */

import java.util.Date;
import lombok.Data;
@Data
public class ReserveVO {
	private int resno, pno, cate;
	private String id, rdate, rtime, confirm, dbresday;
	private Date regdate;
}
