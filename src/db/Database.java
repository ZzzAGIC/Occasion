package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Database {
	private Connection conn;

	public Database() {
		String databaseName = "BookSearch";
		String instanceName = "cs201-255422:us-central1:booksearch";
		String username = "rishabh";
		String password = "rishabh";
		String connection_string = String.format("jdbc:mysql://google/%s?cloudSqlInstance=%s&" + "socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false", 
		        databaseName, instanceName);
		try {
			conn = DriverManager.getConnection(connection_string, username, password);
		} catch (SQLException e) {
			e.printStackTrace();
		}		
	}

	public Map<String, List< Object> > SelectQuery(String query){
		Map<String, List< Object> > result = new HashMap<>();
		String[] keys = query.replace(" ", "").replace("SELECT", "").split("FROM")[0].split(",");
		
		Statement st = null;
		ResultSet rs = null;
		try {				
			st = conn.createStatement();
				
			String statement = String.format(query);
			
			rs = st.executeQuery(statement);

			while (rs.next()) {
	            for (int i = 1; i < keys.length; i++) {
	                result.get(keys[i]).add(rs.getInt(keys[i]));
	            }
        	}
		} catch(SQLException e) {
			System.out.println(e);
		} finally {	
			try {
				st.close();
			} catch(SQLException e) {
				System.out.println(e);
			}
			try {
				rs.close();
			} catch(SQLException e) {
				System.out.println(e);
			}
		}
		return result;
	}

	public void UpdateQuery(String query) {
		Statement st = null;
		try {				
			st = conn.createStatement();			
			String statement = String.format(query);
			st.executeUpdate(statement);
		} catch(SQLException e) {
			System.out.println(e);
		} finally {
			try {
				st.close();
			} catch(SQLException e) {
				System.out.println(e);
			}
		}
	}

	public void Close() throws SQLException {
		conn.close();
	}
}

