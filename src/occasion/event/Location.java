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
		
		setLocationID(Integer.parseInt(result.get(0)));
		setcity(result.get(1));
		setcountry(result.get(2));
		setstate(result.get(3));
		setstreet(result.get(4));
		setzipcode(result.get(5));
		setlongitute(result.get(6));
		setlatitude(result.get(7));
		
		
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
	public void setcity(String ct) {
		city = ct;
	}
	
	public String getstate() {
		return state;
	}
	public void setstate(String st) {
		state = st;
	}
	
	
	public String getcountry() {
		return country;
	}
	public void setcountry(String cont) {
		country = cont;
	}
	
	
	public String getstreet() {
		return street;
	}
	public void setstreet(String str) {
		street = str;
	}
	
	
	public String getzipcode() {
		return zipcode;
	}
	public void setzipcode(String zp) {
		zipcode = zp;
	}
	
	
	public String getlongitute() {
		return longitute;
	}
	public void setlongitute(String lng) {
		longitute = lng;
	}
	
	public String getlatitude() {
		return latitude;
	}
	public void setlatitude(String lat) {
		latitude = lat;
	}
	
	
}
