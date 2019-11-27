package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import occasion.event.Event;
import occasion.account.Post;
import occasion.account.User;

/**
 * Servlet implementation class follow_user
 */
@WebServlet("/GetEventHomePage")
public class GetEventsHomePage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetEventsHomePage() {
        super();
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);	
	    String username = (String)session.getAttribute("myname");
	    
	    User currentUser = new User(username);
	    
	    ArrayList<Event> invitedEvents = currentUser.getInvitedEvents();
	    ArrayList<EventData> invitedData = new ArrayList<EventData>();	    
	    for(Event event : invitedEvents) {
	    	invitedData.add(new EventData(event.getEventName(), event.getPictures()));
	    }
	    
	    EventList list = new EventList();
	    
	    list.setInvited(invitedData);
	    list.setPopular(new ArrayList<Event>());
	    list.setPostActivity(new ArrayList<Post>());
	    
	    String json = new Gson().toJson(list);
	    
		PrintWriter out = response.getWriter();
		out.write(json);
		out.flush();
		out.close();
	}
	
	class EventData {
		private String event_name;
		private String img;
		
		public EventData(String name, String image) {
			this.event_name = name;
			this.img = image;
		}
		public String getEvent_name() {
			return event_name;
		}
		public void setEvent_name(String event_name) {
			this.event_name = event_name;
		}
		public String getImg() {
			return img;
		}
		public void setImg(String img) {
			this.img = img;
		}

	}
	
	class EventList {
		private ArrayList<EventData> invited;
		private ArrayList<Event> popular;
		private ArrayList<Post> postActivity;
		
		public ArrayList<EventData> getInvited() {
			return invited;
		}
		public void setInvited(ArrayList<EventData> invited) {
			this.invited = invited;
		}
		public ArrayList<Event> getPopular() {
			return popular;
		}
		public void setPopular(ArrayList<Event> popular) {
			this.popular = popular;
		}
		public ArrayList<Post> getPostActivity() {
			return postActivity;
		}
		public void setPostActivity(ArrayList<Post> postActivity) {
			this.postActivity = postActivity;
		}
	}
	
	
}
