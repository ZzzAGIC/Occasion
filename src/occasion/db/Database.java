package occasion.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Database {
	
	/**
	 * Creates a connection with the project database
	 * @return A connection object to the database
	 * @throws SQLException
	 */
	private static Connection getConnection() throws SQLException {
		String databaseName = "EventProject";
		String instanceName = "occassion:us-central1:project-instance1";
		String username = "developer";
		String password = "123456";
		String connection_string = String.format("jdbc:mysql://google/%s?cloudSqlInstance=%s&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false", 
		        databaseName, instanceName);
		
		Connection conn = DriverManager.getConnection(connection_string, username, password);
		
		return conn;	
	}
	
	/**
	 * A method that acts as a wrapper for select statements on the database
	 * @param query - An SQL Select statement
	 * @param args - An indefinite number of parameters for the query
	 * @return A map consisting of a mapping of column name to an ordered vector of values
	 */
	public static List<List<String> > SelectQuery(String query, String...args){
	
		//Note to add prescreening of the query to validate it is indeed a SELECT statement 
		
		PreparedStatement st = null;
		ResultSet rs = null;
		Connection conn = null;
		List<List<String> > result = new ArrayList<List<String>>();

		try {				
			conn = getConnection();
			
			st = conn.prepareStatement(query);
			
			for(int i = 0; i < args.length; i++) {
				st.setString(i + 1, args[i]);
			}
			rs = st.executeQuery();
			
			ResultSetMetaData rsmd = rs.getMetaData();
			
			//Loop through the result set appending to the vector that corresponds to the column name
			while (rs.next()) {
				List<String> rowData = new ArrayList<>();
				for(int i = 1; i <= rsmd.getColumnCount(); i++) {
					try {
						rowData.add(rs.getObject(i).toString());
					} catch (Exception e) {
						rowData.add("");
					}
				}
				System.out.println(rowData);
				result.add(rowData);
			}
			return result;
		} catch(SQLException e) {
			System.out.println(e.getMessage());
		} finally {	
			try {
				if(rs != null) rs.close();
				if(st != null) st.close();
				if(conn != null) conn.close();
			}
			catch(SQLException e) {
				System.out.println(e.getMessage());
			}		
		}
		return result;
	}
	
	/**
	 * A method that acts as a wrapper for an SQL Statement that has no result set
	 * @param query - An SQL Remove Query
	 * @param args - An indefinite number of parameters for the query
	 */
	public static void UpdateQuery(String query, String...args) {
		PreparedStatement st = null;
		Connection conn = null;
		try {				
			conn = getConnection();
			st = conn.prepareStatement(query);
			for(int i = 0; i < args.length; i++) {
				st.setString(i + 1, args[i]);
			}
			
			st.executeUpdate();
		} catch(SQLException e) {
			System.out.println(e);
		} finally {
			try {
				if(st != null) st.close();
				if(conn != null) conn.close();
			}
			catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
	}
}

