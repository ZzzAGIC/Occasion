package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import occasion.db.Database;

/**
 * Servlet implementation class new_group
 */
@WebServlet("/new_group")
public class new_group extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public new_group() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String members [] = request.getParameterValues("members");
		String groupName = request.getParameter("GroupName");
		String picture = request.getParameter("Picture");
		String description = request.getParameter("Description");
		String next = "/FriendlistPage.jsp";
		String error = "";
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("myname");
		
		if(members.length == 1) {
			error += "Only one member & ";
			next = "/FriendlistPage.jsp";
		}
		
		String groupID = null;
		try {
			groupID = AddGroup(groupName, picture, description, username);
		} catch (SQLException e){
			e.printStackTrace();
		} catch (ClassNotFoundException e){
			e.printStackTrace();
		}
		
		try {
			AddMembers(members,groupID);
		} catch (SQLException e){
			e.printStackTrace();
		} catch (ClassNotFoundException e){
			e.printStackTrace();
		}
		
		
		
		request.setAttribute("error", error);
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
			
		try {
			dispatch.forward(request,response);
		}
		catch (IOException e){
			e.printStackTrace();
		}
		catch (ServletException e){
			e.printStackTrace();
		}
	}
	
	
	public static String AddGroup(String groupName, String picture, String description, String username) throws SQLException, ClassNotFoundException {
		//get userID
				String searchUser = "SELECT UserID FROM User WHERE Username = ?";
				List<List<String>> curr_ID = Database.SelectQuery(searchUser, username);
				String U_ID = curr_ID.get(0).get(0);
			
		//add group
		String toinsert = "INSERT INTO FriendGroup (GroupName,Picture,Description,OwnerID) "
				+ "VALUES (?,?,?,?)";
		
		Database.UpdateQuery(toinsert, groupName,picture,description,U_ID);
		
		
		//get GroupID
		String searchGroup = "SELECT GroupID FROM FriendGroup WHERE GroupName = ?";
		List<List<String>> GID = Database.SelectQuery(searchGroup, groupName);
		String group_ID = GID.get(0).get(0);
		
		String insertowner = "INSERT INTO GroupUser (GroupID,UserID) "
				+ "VALUES (?,?)";
		
		Database.UpdateQuery(insertowner, group_ID,U_ID);
		
		return group_ID;

	}
	public static void AddMembers(String[] MembersID, String GroupID) throws SQLException, ClassNotFoundException {
		
		for(int i = 0; i < MembersID.length; i++) {
			String toinsert = "INSERT INTO GroupUser (GroupID,UserID) "
					+ "VALUES (?,?)";
			
			Database.UpdateQuery(toinsert, GroupID,MembersID[i]);
		}
			
		


	}

}
