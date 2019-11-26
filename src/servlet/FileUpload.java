package servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import occasion.db.Database;

/**
 * Servlet implementation class EditProfile
 */
@WebServlet("/FileUpload")
@MultipartConfig
public class FileUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileUpload() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Part filepart = request.getPart("newfile");
		InputStream	is = null;
		
		if(filepart != null) {
			is = filepart.getInputStream();
		}
		
		HttpSession session = request.getSession(false);
		String name = (String)session.getAttribute("myname");
		
		//Database.UpdateQuery("UPDATE User SET ProfileImage = ? WHERE Username = ?", name);
		is.close();
		
	}

}
