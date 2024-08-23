package com.sist.vo;

import lombok.Data;

@Data
public class DressVO {
	private int d_no;
	private String d_image, d_subject, d_content, d_delivery, d_return_exchange,
				   d_detail_image, d_detail_image2, d_detail_image3,
				   d_price, d_hour, d_dayoff, d_address;
}
