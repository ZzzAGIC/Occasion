package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
import occasion.db.Database;

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
	    	invitedData.add(new EventData(event.getEventName(), event.getPictures(), event.getEventID(), event.getEventTime()));
	    }
	    
	    ArrayList<Event> popularEvents = Event.getPopularEvents();
	    ArrayList<EventData> popularData = new ArrayList<EventData>();	    
	    for(Event event : popularEvents) {
	    	popularData.add(new EventData(event.getEventName(), event.getPictures(), event.getEventID(), event.getEventTime()));
	    }
	    
//	    List<List<String>> posts = Database.SelectQuery("SELECT * FROM Post Where UserID IN (SELECT FollowingUserID FROM Relationship WHERE FollowingUserID = ?) ", username);
	    ArrayList<Post> posts = currentUser.getFriendPost();
	    ArrayList<Post> postData = new ArrayList<Post>();
	    for(Post post : posts) {
	    	postData.add(post);
//	    	System.out.println(post.getPost_text());
	    }
	    
	    EventList list = new EventList();
	    
	    list.setInvited(invitedData);
	    list.setPopular(popularData);
	    list.setPostActivity(postData);
	    
	    String json = new Gson().toJson(list);
	    System.out.println(json);
	    
		PrintWriter out = response.getWriter();
		out.write(json);
		out.flush();
		out.close();
	}
	
	class EventData {
		private String event_name;
		private String img;
		private Date date;
		private int id;
		
		public EventData(String name, String image, int id, Date date) {
			this.event_name = name;
			this.img = image;
			this.id = id;
			this.date = date;
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

		public int getId() {
			return id;
		}


		public void setId(int id) {
			this.id = id;
		}

		public Date getDate() {
			return date;
		}

		public void setDate(Date date) {
			this.date = date;
		}

	}
	
	class EventList {
		private ArrayList<EventData> invited;
		private ArrayList<EventData> popular;
		private ArrayList<Post> postActivity;
		
		public ArrayList<EventData> getInvited() {
			return invited;
		}
		public void setInvited(ArrayList<EventData> invited) {
			this.invited = invited;
		}
		public ArrayList<EventData> getPopular() {
			return popular;
		}
		public void setPopular(ArrayList<EventData> popular) {
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
