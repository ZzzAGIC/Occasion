package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import occasion.account.Post;
import occasion.account.User;
import occasion.event.Event;
import servlet.GetEventsHomePage.EventData;
import servlet.GetEventsHomePage.EventList;

/**
 * Servlet implementation class GetRecommendedEvents
 */
@WebServlet("/GetRecommendedEvents")
public class GetRecommendedEvents extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetRecommendedEvents() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);	
	    String username = (String)session.getAttribute("myname");
	    
	    User currentUser = new User(username);
	    
	    Set<Event> recommendedEvents = currentUser.getRecommendedEvents();
	    ArrayList<EventData> recommendedEventData = new ArrayList<EventData>();	    
	    for(Event event : recommendedEvents) {
	    	recommendedEventData.add(new EventData(event.getEventName(), event.getPictures(), event.getEventID(), event.getEventTime()));
	    }
	    EventList list = new EventList();
	    
	    list.setRecommended(recommendedEventData);
	    
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
		private ArrayList<EventData> recommended;
		
		public ArrayList<EventData> getRecommended() {
			return recommended;
		}
		public void setRecommended(ArrayList<EventData> recommended) {
			this.recommended = recommended;
		}
		
	}
}
