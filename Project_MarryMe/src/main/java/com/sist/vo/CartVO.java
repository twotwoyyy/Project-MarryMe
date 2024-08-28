package com.sist.vo;
/*
 *   CNO     NOT NULL NUMBER       
	GNO              NUMBER       
	TYPE             NUMBER       
	ID               VARCHAR2(20) 
	ACCOUNT          NUMBER       
	PRICE            NUMBER       
	ISBUY            CHAR(1)      

 */
import java.util.*;

import lombok.Data;
@Data
public class CartVO {
  private int cart_no,gno,account,price;
  private String id,isbuy,dbday,won;
  private Date regdate;
  private GoodsVO gvo=new GoodsVO();
}