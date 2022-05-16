package servlet;

import util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "RecordServlet",
        urlPatterns = "/record"
)
public class RecordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
    
        Map<String, Object> params = new HashMap<>();
    
        Map<String, String[]> parameterMap = request.getParameterMap();
        if (parameterMap != null) {
            for (Map.Entry<String, String[]> entry : parameterMap.entrySet()) {
                params.put(entry.getKey(), entry.getValue()[0]);
            }
        }

        String id = (String) params.get("id");
    
        boolean isTrue = false;
        try {
            Connection conn = DBUtil.getConn();
            PreparedStatement ps = null;
            String sql = "";
            // 准备一个sql语句
            if (id == null) {
                sql = "INSERT INTO record (uid,method,result,created_at) VALUES(?,?,?,?)";

                ps = conn.prepareStatement(sql);
                ps.setString(1, (String) params.get("uid"));
                ps.setString(2, (String) params.get("method"));
                ps.setString(3, (String) params.get("result"));
                ps.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            }else {
                sql = "UPDATE record SET uid=?,method=?,result=? where id="+id;
                ps = conn.prepareStatement(sql);
                ps.setString(1, (String) params.get("uid"));
                ps.setString(2, (String) params.get("method"));
                ps.setString(3, (String) params.get("result"));
            }
            // 用PreparedStatement交互数据库

            // 用count显示影响的行数
            int count = ps.executeUpdate();
            // 展示页面
            if (count > 0) {
                isTrue = true;
            } else {
                isTrue = false;
            }
            DBUtil.close(conn, ps, null);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("  <head> <meta charset=\"utf-8\"><title>添加出入记录</title></head>");
        out.println("  <body>");
        if (isTrue) {
            out.println("<h3>添加成功</h3>");
            out.println("<a href='./'>返回首页</a>");
//            out.println("<p>你添加的姓名为：" + params.get("name") + "</p>");
//            out.println("<p>你添加的身份证号为：" + params.get("idcard") + "</p>");
//            out.println("<p>你添加的手机号为：" + params.get("phone") + "</p>");
//            out.println("<p>你添加人员类型为：" + params.get("type") + "</p>");
        } else {
            out.println("<h1>添加失败！！！</h1>");
            out.println("<a href='./'>返回首页</a>");
        }
        out.println("  </body>");
        out.println("</html>");
        out.flush();
        out.close();
    }
}
