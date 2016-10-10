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

import net.sf.json.JSONArray;
import cn.arvin.tem.util.DBUtil;

@WebServlet("/gettable")
public class GetServlet extends HttpServlet {
	private static final long serialVersionUID = 5077536041644993273L;

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
		Connection conn = DBUtil.getConnection(driver, url, username, password);
		try {
			PreparedStatement ps = conn.prepareStatement("show tables");
			ResultSet rs = ps.executeQuery();
			List<String> tables = new ArrayList<String>();
			while (rs.next()) {
				tables.add(rs.getString(1));
			}
			rs.close();
			ps.close();
			DBUtil.close(conn);
			
			JSONArray json = JSONArray.fromObject(tables);
			response.setContentType("text/plain;charset=utf-8");
			response.getWriter().print(json.toString());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
