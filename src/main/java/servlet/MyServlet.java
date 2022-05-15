package servlet;

import bean.User;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

//@WebServlet(name = "Servlet", value = "/Servlet")

//@WebServlet(name = "Servlet")
public class MyServlet extends HttpServlet {
    Connection dbconn = null;
    public void init() {
        String dburl  = "jdbc:mysql://127.0.0.1:3306/servlet_table?useSSL=false&serverTimezone=UTC";
        String username ="root";
        String password = "Qiqin5150317";
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            dbconn = DriverManager.getConnection(dburl,username,password);
            System.out.println("数据库连接成功");
        }catch (ClassNotFoundException e1){
            System.out.println(e1+"驱动程序找不到");
        }catch(SQLException e2){
            System.out.println(e2);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.getWriter().println("my first servlet code");

        ArrayList<User> userList = null;
        userList = new ArrayList<User>();

        String sql = "select * from user";
        PreparedStatement pstmt = null;
        try {
            pstmt = dbconn.prepareStatement(sql);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        try {
            ResultSet result = pstmt.executeQuery();
            while (result.next()) {
                User user = new User();
                user.setId(result.getInt("id"));
                user.setIdcard(result.getString("idcard"));
                user.setName(result.getString("name"));
                user.setPhone(result.getString("phone"));
                user.setType(result.getInt("type"));
                userList.add(user);
            }

            if(!userList.isEmpty()){
                request.getSession().setAttribute("userList",userList);
                response.sendRedirect("index.jsp");
            }else{
                response.sendRedirect("error.jsp");
            }

            System.out.printf(String.valueOf(result));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
