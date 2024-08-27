package com.sist.vo;

import lombok.Data;
import java.util.*;

@Data
public class DataBoardVO {
  private int no,hit,filesize;
  private String name,subject,content,pwd,dbday,filename;
  private Date regdate;
}