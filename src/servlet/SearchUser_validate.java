package servlet;

import java.io.IOException;
import java.sql.SQLException;
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
 * Servlet implementation class SearchUser_validate
 */
@WebServlet("/SearchUser_validate")
public class SearchUser_validate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchUser_validate() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
					String search_content = request.getParameter("search");
					String search_type = request.getParameter("selection");
					
					String next = "/FriendlistPage.jsp";
					String error = "";
					HttpSession session = request.getSession();
					boolean login = (boolean) session.getAttribute("login");
					
					if(!login) {
						error += "Username cannot be empty & ";
						next = "/FriendlistPage.jsp";
					}

					if(search_content =="") {
						error += "Search content cannot be empty & ";
						next = "/FriendlistPage.jsp";
					}
					
					try {
						List<List<String>> output= SearchUser(search_content,search_type);
						if (output.size() > 0) {	
							
						}
						else if(output.size() == 0){
							error += "User does not exist! & ";
							next = "/FriendlistPage.jsp";
						}
					}
					catch (SQLException e){
						e.printStackTrace();
					}
					catch (ClassNotFoundException e){
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
			    
	public static List<List<String>> SearchUser(String content, String type) throws SQLException, ClassNotFoundException {
		
		String tosearch = "SELECT * FROM User WHERE " + type + " = ?";
		List<List<String>> output = Database.SelectQuery(tosearch, content);
		return output;
		
	}

}
