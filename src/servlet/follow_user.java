package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import occasion.db.Database;
import occasion.account.User;

/**
 * Servlet implementation class follow_user
 */
@WebServlet("/follow_user")
public class follow_user extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public follow_user() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String follower = request.getParameter("Follower");
		String following = request.getParameter("Following");
		User alpha = new User(follower);
		User beta = new User(following);
		int followerID = alpha.getUserID();
		int followingID = beta.getUserID();
		try{
			add_following(followerID,followingID);
		}
		catch (SQLException e){
			e.printStackTrace();
		}
		catch (ClassNotFoundException e){
			e.printStackTrace();
		}
	}
	
	public static void add_following(int followerID, int followingID) throws SQLException, ClassNotFoundException {
		
		String tosearch = "SELECT * FROM Relationship WHERE followerID = ? AND followingID = ?";
		List<List<String>> output = Database.SelectQuery(tosearch, "followerID", "followingID");
		if(output.size() == 0) {
		
			String toinsert = "INSERT INTO Relationship (FollowerUserID,FollowingUserID, BlockCode) "
				+ "VALUES (?, ?, ?)";
		
			Database.UpdateQuery(toinsert, "followerID", "followingID", "0");
		}
		
	
	}
		
}
