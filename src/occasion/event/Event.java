package occasion.event;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import occasion.account.User;
import occasion.db.Database;
import occasion.event.Location;

public class Event {
	private int eventID;
	private String event_name;
	private User initiator;
	private String type;
	private Location location;
	private Date event_time;
	private int capacity;
	private int curr_num;
	private ArrayList<User> attendants;
//	private ArrayList<String> pictures;
	private String img;
	private int private_event;
	//public event = 0; private event = 1; exclusive event = 2;
	
	public Event() {
		
	}
	
	//constructor
	public Event(int eventID) {
		this.setEventID(eventID);
		String query = "SELECT * FROM Event WHERE eventID = ?";
		
		List<String> result = Database.SelectQuery(query, Integer.toString(eventID)).get(0);
		
		setEventID(Integer.parseInt(result.get(0)));
		setEventName(result.get(1));
		
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		try {
			setEventTime(formatter.parse(result.get(2)));
		} catch (ParseException e) {
			//NOTE TO SELF: Add placeholder date
		}
		
		//Set Location
		int loc_id = Integer.parseInt(result.get(3));
		Location curr_loc = new Location(loc_id);
		setLocation(curr_loc);
		//Set Event Type
		setType(result.get(4));
		
		//Set Picture
		setPictures(result.get(5));
		
		//Set Host
		String name = User.getUsernameFromId(Integer.parseInt(result.get(6)));
		setInitiator(new User(name));
		
		//Set Capacity
		setCapacity(Integer.parseInt(result.get(7)));
		
		//Set Size
		setCurrNum(Integer.parseInt(result.get(8)));
		
		//Set Price
		
		//set description result.get(10)
		
		//set privacy result.get(11)
	}

	public int getEventID() {
		return eventID;
	}
	public void setEventID(int id_) {
		eventID = id_;
	}

	public String getEventName() {
		return event_name;
	}
	public void setEventName(String name_) {
		event_name = name_;
	}

	public User getInitiator() {
		return initiator;
	}
	public void setInitiator(User U) {
		initiator = U;
	}

	public String getType() {
		return type;
	}
	public void setType(String type_) {
		type = type_;
	}

	public Location getLocation() {
		return location;
	}
	public void setLocation(Location L) {
		location = L;
	}

	public Date getEventTime() {
		return event_time;
	}
	public void setEventTime(Date D) {
		event_time = D;
	}

	public int getCapacity() {
		return capacity;
	}
	public void setCapacity(int C) {
		capacity = C;
	}

	public int getCurrNum() {
		return curr_num;
	}
	public void setCurrNum(int N) {
		curr_num = N;
	}
	public void incrementCurrNum() {
		curr_num ++;
	}

	public ArrayList<User> getAttendants(){
		return attendants;
	}
	public void addAttendants(User U) {
		attendants.add(U);
	}
	
	public void setPictures(String img_){
//		pictures.add(img);
		img = img_;
	}
		
	public String getPictures(){
//		return pictures;
		return img;
	}
//	public void addPictures(String P) {
//		pictures.add(P);
//	}

	public String getPrivate_event() {
		String type_ =  null;
		if(private_event == 0) {
			type_ = "public"; 
		}
		else if(private_event == 1) {
			type_ = "privae"; 
		}
		else if(private_event == 2) {
			type_ = "exclusive"; 
		}
		return type_;
	}

	public void PrintDetails() {
		System.out.println("EventName: " + getEventName());
		System.out.println("Type: " + getType());
		System.out.println("Private: " + getPrivate_event());
	}
	
}
