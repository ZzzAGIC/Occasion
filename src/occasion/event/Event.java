package occasion.event;

import java.util.ArrayList;
import java.util.Date;

import occasion.account.User;
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
	private ArrayList<String> pictures;
	private boolean private_event;
	
	public Event() {
		
	}
	
	//constructor
	
	
}
