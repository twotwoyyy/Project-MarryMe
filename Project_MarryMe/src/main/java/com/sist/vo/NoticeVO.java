package com.sist.vo;
import java.util.*;

import lombok.Data;
@Data
public class NoticeVO {
	private int no,type,hit;
	private String name,subject,content,id,dbday,notice_type;
	private Date regdate;
}
