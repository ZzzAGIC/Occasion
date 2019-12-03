package servlet;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.apache.tomcat.util.http.fileupload.RequestContext;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

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
		Part filePart = request.getPart("newfile");
		
		if(filePart == null) {
			System.out.println("No image");
		}
		

        String uploadFolder = getServletContext().getRealPath("") + File.separator + "images";   
		HttpSession session = request.getSession(false);	
	    String filename = session.getAttribute("myname") + Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); 
        	   
        InputStream fileContent = filePart.getInputStream();
        
        String filepath = uploadFolder + "/" + filename;
        
        File file = new File(filepath);
        
        try(OutputStream outputStream = new FileOutputStream(file)){
            IOUtils.copy(fileContent, outputStream);
            Database.UpdateQuery("UPDATE User SET ProfileImage = ? WHERE Username = ?", "images/" + filename, session.getAttribute("myname").toString());
        } catch (FileNotFoundException e) {
            System.out.println("File not found");
        } catch (IOException e) {
            System.out.println("IO Exception");
        }
		
        RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/ProfilePage.jsp");
		
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

}
