package servlet;

import java.io.IOException;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import occasion.db.Database;
import occasion.map.Map;

/**
 * Servlet implementation class Addevent_validate
 */
@WebServlet("/Addevent_validate")
public class Addevent_validate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Addevent_validate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String event_name= request.getParameter("EventName");
		System.out.println("name " + event_name);
		String day= request.getParameter("day");
		if(day.length() == 1) {
			day = '0' + day;
		}
		String month= request.getParameter("month");
		String year= request.getParameter("year");
		String hour= request.getParameter("hour");
		if(hour.length() == 1) {
			hour = '0' + hour;
		}
		String minute= request.getParameter("minute");
		if(minute.length() == 1) {
			minute = '0' + minute;
		}
		String total_time = year+"-"+month+"-"+day+" "+hour+":"+minute+":00";
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date event_time = null;
		try {
			event_time = (Date) formatter.parse(total_time);
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		System.out.print(event_time);
		String sql_date = formatter.format(event_time);
		System.out.print(sql_date);
		
		String street= request.getParameter("EventLocation_street");
		String room= request.getParameter("EventLocation_Room");
		String city= request.getParameter("EventLocation_city");
		String state= request.getParameter("EventLocation_state");
		String country= request.getParameter("EventLocation_country");
		String zipcode= request.getParameter("EventLocation_zipcode");
		String type= request.getParameter("EventType");
		int capacity= Integer.parseInt(request.getParameter("EventCapacity"));
		int price= Integer.parseInt(request.getParameter("EventPrice"));
		String description= request.getParameter("EventDescription");
		String private_type= request.getParameter("privacy");
		String img= request.getParameter("EventImages");
			
		String next = "/MyEventPage.jsp";
		String error = "";
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("myname");
			

		if(event_name =="") {
			error += "EventName cannot be empty & ";
			next = "/AddEventPage.jsp";
		}
//		LocalTime nowtime = LocalTime.now();
//		System.out.print(nowtime);
//		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
//		String timeString = nowtime.format(formatter);
//		Date curr_time = null;
//		try {
//			curr_time = (Date) format.parse(timeString);
//		} catch (ParseException e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
//		System.out.print(curr_time);
//		
//		if(event_time.before(curr_time)) {
//			error += "Can't hold event in the past& ";
//			next = "/AddEventPage.jsp";
//		}
		
		if(street =="") {
			error += "Street cannot be empty & ";
			next = "/AddEventPage.jsp";
		}
		if(city =="") {
			error += "City cannot be empty & ";
			next = "/AddEventPage.jsp";
		}
		
		if(country =="") {
			error += "Country cannot be empty & ";
			next = "/AddEventPage.jsp";
		}
//		if(zipcode =="") {
//			error += "Zipcode cannot be empty & ";
//			next = "/AddEventPage.jsp";
//		}
		
		if(type =="") {
			error += "Give the type of your event & ";
			next = "/AddEventPage.jsp";
		}
		if(capacity <=0) {
			error += "Capacity too small & ";
			next = "/AddEventPage.jsp";
		}
		if(price < 0) {
			error += "You want to pay whoever attend? & ";
			next = "/AddEventPage.jsp";
		}
		if(description =="") {
			error += "At least tell something about your event & ";
			next = "/AddEventPage.jsp";
		}
		//more errors
		
		List<String> geocode = Map.getGeocode(street, room, city, state, country, zipcode);
		String latitude = geocode.get(0);
		String longitude = geocode.get(1);
		String loc_ID = null;
		
		//add/verify location
		try {
			loc_ID = AddLocation(street,room,city,state,country,zipcode,latitude,longitude);
		} catch (SQLException e){
			e.printStackTrace();
		} catch (ClassNotFoundException e){
			e.printStackTrace();
		}
		
		
		//add event
		try {
			//addevent 
			if (AddEvent(event_name,sql_date,loc_ID,type,img,capacity,price,description,username,private_type)) {
			
			}
			//login failed
			else {
				error += "unable to add event  & ";
				next = "/AddEventPage.jsp";
			}
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
	public static String AddLocation(String street, String room, String city, String state,
			String country, String zipcode,String latitude, String longitude) throws SQLException, ClassNotFoundException {
		
		String Loc_ID = null;
		String tosearch = "SELECT * FROM Location WHERE City = ? AND Country = ? AND State = ? AND "
				+ "Street = ? AND Zipcode = ?";
		List<List<String>> output = Database.SelectQuery(tosearch, city,country,state,street,zipcode);
		//if the location not exist yet, need to add now 
		if(output.size() == 0) {
			System.out.println("insert location");
			String toinsert = "INSERT INTO Location (City,Country,State, Street,Zipcode,Longitude,Latitude) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?)";
			Database.UpdateQuery(toinsert, city, country, state, street,zipcode,longitude,latitude);
		
		}
		List<List<String>> output1 = Database.SelectQuery(tosearch, city,country,state,street,zipcode);
		
//		return the loc_ID
		Loc_ID = output1.get(0).get(0);
		return Loc_ID;

	}
	
	public static boolean AddEvent(String event_name, String event_time, String loc_ID, String type, String img, int capacity, int price, String description,String username,String privacy)
			 throws SQLException, ClassNotFoundException{
		String tosearch = "SELECT * FROM Event WHERE EventName = ? AND EventDate = ? AND LocationID = ? AND Description = ?";
		String event_date = event_time.toString();
		List<List<String>> output = Database.SelectQuery(tosearch, event_name, event_date, loc_ID, description);
		if(output.size() > 0) return false;
		
		//get userID
		String searchUser = "SELECT UserID FROM User WHERE Username = ?";
		List<List<String>> curr_ID = Database.SelectQuery(searchUser, username);
		String U_ID = curr_ID.get(0).get(0);
		
		String toinsert = "INSERT INTO Event (EventName,EventDate,LocationID,Type,Picture,HostID,Capacity,Size,Price,Description,Privacy) "
				+ "VALUES (?,?,?,?,?,?,?,?,?,?,?)";
		String capacity_ = Integer.toString(capacity);
		String price_ = Integer.toString(price);
		Database.UpdateQuery(toinsert, event_name, event_date, loc_ID, type,img, U_ID, capacity_,"0", price_, description,privacy);
		return true;
	}

}
