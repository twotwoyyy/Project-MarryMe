
package com.sist.model;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.sist.controller.RequestMapping;
import com.sist.dao.MemoDAO;
import com.sist.vo.MemoVO;

public class MemoModel {
    @RequestMapping("memo/list.do")
    public void memo_list(HttpServletRequest request, HttpServletResponse response) {
        String id = (String) request.getSession().getAttribute("id");

        if (id == null || id.isEmpty()) {
            try {
                response.setContentType("application/json;charset=UTF-8");
                PrintWriter out = response.getWriter();
                out.write("[]"); // ID가 없으면 빈 배열 반환
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            return;
        }

        Map map = new HashMap();
        map.put("id", id);

        List<MemoVO> list = MemoDAO.memoListData(map);
        JSONArray arr = new JSONArray();

        for (MemoVO vo : list) {
            JSONObject obj = new JSONObject();
            obj.put("mno", vo.getMno()); // 댓글 번호
            obj.put("cno", vo.getCno());
            obj.put("cate", vo.getCate());
            obj.put("id", vo.getId());
            obj.put("name", vo.getName());
            obj.put("msg", vo.getMsg());
            obj.put("dbday", vo.getDbday());
            arr.add(obj);
        }

        try {
            response.setContentType("application/json;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.write(arr.toJSONString());
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
    @RequestMapping("memo/delete.do")
    public void memo_delete(HttpServletRequest request, HttpServletResponse response) {
        String mno = request.getParameter("mno");
        String id = request.getParameter("id"); // Optional: If needed for validation

        String result = "";
        try {
            MemoDAO.memoDelete(Integer.parseInt(mno));
            result = "OK";
        } catch (Exception ex) {
            result = ex.getMessage();
            ex.printStackTrace();
        }
        try {
            PrintWriter out = response.getWriter();
            out.write(result);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @RequestMapping("memo/update.do")
    public void memo_update(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        String mno = request.getParameter("mno");
        String msg = request.getParameter("msg");

        Map map = new HashMap();
        map.put("mno", Integer.parseInt(mno));
        map.put("msg", msg);

        String result = "";
        try {
            MemoDAO.memoUpdate(map);
            result = "OK";
        } catch (Exception ex) {
            result = ex.getMessage();
            ex.printStackTrace();
        }
        try {
            PrintWriter out = response.getWriter();
            out.write(result);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
