package servlet;

import bean.RecordUser;
import bean.User;
import util.DBUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

@WebServlet(name = "MyServlet", value = "/",  loadOnStartup = 1)
public class MyServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<RecordUser> recordList = null;
        recordList = new ArrayList<RecordUser>();
        ArrayList<User> userList = null;
        userList = new ArrayList<User>();
    
        try {
            Connection conn = DBUtil.getConn();
            // 准备一个sql语句
            String sql = "select r.*,u.id as uid,u.name,u.idcard,u.phone,u.type from record r left join user u on u" +
                                 ".id=r.uid";
            String sql2 = "select * from user";
            // 用PreparedStatement交互数据库
            PreparedStatement ps = conn.prepareStatement(sql);
            PreparedStatement ps2 = conn.prepareStatement(sql2);
    
            ResultSet result = ps.executeQuery();
            ResultSet result2 = ps2.executeQuery();
            while (result.next()) {
                RecordUser record = new RecordUser();
                record.setId(result.getInt("id"));
                record.setIdcard(result.getString("idcard"));
                record.setName(result.getString("name"));
                record.setPhone(result.getString("phone"));
                record.setType(result.getInt("type"));
                record.setMethod(result.getInt("method"));
                record.setResult(result.getInt("result"));
                record.setCreated_at(result.getTimestamp("created_at"));
                recordList.add(record);
            }
    
            while (result2.next()) {
                User user = new User();
                user.setId(result2.getInt("id"));
                user.setIdcard(result2.getString("idcard"));
                user.setName(result2.getString("name"));
                user.setPhone(result2.getString("phone"));
                user.setType(result2.getInt("type"));
                userList.add(user);
            }
    
            if(!recordList.isEmpty()){
                request.getSession().setAttribute("recordList",recordList);
                request.getSession().setAttribute("userList",userList);
                response.sendRedirect("list.jsp");
            }else{
                response.sendRedirect("error.jsp");
            }
            
            DBUtil.close(conn, ps, null);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
