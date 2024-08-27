package com.sist.vo;

import java.util.*;

import lombok.Data;
@Data
public class ReplyBoardVO {
  private int no,group_id,group_step,isreply,hit;
  private String id,name,subject,content,dbday;
  private Date regdate;
}