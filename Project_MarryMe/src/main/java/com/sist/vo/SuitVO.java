package com.sist.vo;

import java.util.*;

import lombok.Data;

@Data
public class SuitVO {
	private int su_no;
	private String su_image, su_subject, su_content, su_delivery, su_return_exchange,
				   su_detail_image,  su_price, su_address, su_hour, su_dayoff;
}