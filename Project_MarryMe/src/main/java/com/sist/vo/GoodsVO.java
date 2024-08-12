package com.sist.vo;

import lombok.Data;

/*
 * MGNO	NUMBER	No		1	
TITLE	VARCHAR2(4000 BYTE)	No		2	
PRICE	VARCHAR2(4000 BYTE)	No		3	
DISCOUNT	VARCHAR2(4000 BYTE)	Yes		4	
DELIVERY	VARCHAR2(4000 BYTE)	Yes		5	
CATEGORY	VARCHAR2(4000 BYTE)	Yes		6	
POSTER	VARCHAR2(4000 BYTE)	Yes		7	
EA	NUMBER	No		8	
 */
@Data
public class GoodsVO {
	private int mgno,EA,firstprice;
	private String title,price,discount,delivery,category,poster;
}
