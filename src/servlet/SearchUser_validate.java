package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import occasion.account.User;
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
					
    	System.out.println(request.getQueryString());
					String search_content = (String) request.getParameter("search");
					String search_type = (String) request.getParameter("type");
					
					System.out.println(search_content + "-" + search_type);
					
					String next = "/UserSearchResult.jsp";
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
						ArrayList<User> users = new ArrayList();
						PrintWriter out = response.getWriter();

						if(output.size() == 0) {
							out.write("EMPTY");
						} else {
							for(List<String> user : output) {
								users.add(new User(user));
							}
							
							String json = new Gson().toJson(users);
							out.write(json);
						}
						out.flush();
						out.close();
					    
						
						if (output.size() > 0) {	
							request.setAttribute("searchresult", output);
							request.setAttribute("content", search_content);
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
			}
			    
	public static List<List<String>> SearchUser(String content, String type) throws SQLException, ClassNotFoundException {
		
		String tosearch = "SELECT * FROM User WHERE " + type + " LIKE ?;";
		content = content + "%";
		List<List<String>> output = Database.SelectQuery(tosearch, content);
		return output;		
	}
}
