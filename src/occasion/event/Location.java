package occasion.event;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import occasion.account.User;
import occasion.db.Database;

public class Location {
	private int locationID;
	private String city;
	private String state;
	private String country;
	private String street;
	private String zipcode;
	private String longitute;
	private String latitude;
	
	public Location() {
		
	}
	
	//constructor
	public Location(int locationID_) {
		this.setLocationID(locationID_);
		String query = "SELECT * FROM Location WHERE LocationID = ?";
		
		List<String> result = Database.SelectQuery(query, Integer.toString(locationID)).get(0);
		
		
	}
	
	
	public int getlocationID() {
		return locationID;
	}
	public void setLocationID(int loc_ID) {
		this.locationID = loc_ID;
	}
	
	public String getcity() {
		return city;
	}
	
	public String getstate() {
		return state;
	}
	
	public String getcountry() {
		return country;
	}
	
	public String getstreet() {
		return street;
	}
	
	public String getzipcode() {
		return zipcode;
	}
	
	public String getlongitute() {
		return longitute;
	}
	
	public String getlatitude() {
		return latitude;
	}
	
	
}
