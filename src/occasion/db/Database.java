package occasion.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Database {
	private Connection conn;

	
	public Database() throws Exception {
		String databaseName = "NAME";
		String instanceName = "INSTANCE_NAME";
		String username = "USERNAME";
		String password = "PASSWORD";
		String connection_string = String.format("jdbc:mysql://google/%s?cloudSqlInstance=%s&" + "socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false", 
		        databaseName, instanceName);
		
		conn = DriverManager.getConnection(connection_string, username, password);	
	}
	
	/**
	 * A method that acts as a wrapper for select statements on the database
	 * @param query - An SQL Select statement
	 * @return A map consisting of a mapping of column name to an ordered vector of values
	 */
	public Map<String, List< Object> > SelectQuery(String query){
		Map<String, List< Object> > result = new HashMap<>();
		
		//Note to add prescreening of the query to validate it is indeed a SELECT statement 
		
		//Generate a list of column names
		String[] keys = query.replace(" ", "").replace("SELECT", "").split("FROM")[0].split(",");
		
		Statement st = null;
		ResultSet rs = null;
		try {				
			st = conn.createStatement();
				
			String statement = String.format(query);
			
			rs = st.executeQuery(statement);
			
			//Loop through the result set appending to the vector that corresponds to the column name
			while (rs.next()) {
				for (int i = 1; i < keys.length; i++) {
					result.get(keys[i]).add(rs.getString(keys[i]));
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
	
	/**
	 * A method that acts as a wrapper for an SQL Statement that has no result set
	 * @param query - An SQL Remove Query
	 */
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
	
	/**
	 * Closes the connection 
	 * @throws SQLException
	 */
	public void Close() throws SQLException {
		conn.close();
	}
}

