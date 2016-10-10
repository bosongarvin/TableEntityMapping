package cn.arvin.tem.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DB Utils Class
 * @author ZhangBosong
 * @createDate 2016年10月10日 下午2:51:51
 */
public final class DBUtil {
	private DBUtil() {}
	
	public static Connection getConnection(String driver, String url, String username, String password) {
		Connection conn = null;
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, username, password);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	public static void close(Connection conn) {
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
	}
}
