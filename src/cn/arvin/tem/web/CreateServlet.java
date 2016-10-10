package cn.arvin.tem.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import cn.arvin.tem.util.CodeUtil;
import cn.arvin.tem.util.DBUtil;

@WebServlet("/create")
public class CreateServlet extends HttpServlet {
	private static final long serialVersionUID = -8463172513907739776L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String driver = request.getParameter("driver");
		String url = request.getParameter("url");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String tablename = request.getParameter("tablename");
		Connection conn = DBUtil.getConnection(driver, url, username, password);
		try {
			PreparedStatement ps = 
					conn.prepareStatement("SELECT  column_name  FROM Information_schema.columns  WHERE table_Name = ?");
			ps.setString(1, tablename);
			ResultSet rs = ps.executeQuery();
			List<String> columns = new ArrayList<String>();
			while (rs.next()) {
				columns.add(rs.getString("column_name"));
			}
			rs.close();
			ps.close();
			DBUtil.close(conn);
			
			String resultMap = CodeUtil.createResultMap(columns);
			JSONObject json = new JSONObject();
			json.put("result", resultMap);
			json.put("msg", "生成成功");
			response.setContentType("text/plain;charset=utf-8");
			response.getWriter().print(json.toString());
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
