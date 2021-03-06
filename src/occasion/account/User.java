package occasion.account;

import java.io.File;
import java.text.ParseException;

import java.text.SimpleDateFormat;
import java.util.AbstractMap;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.PriorityQueue;
import java.util.Set;
import java.util.TreeSet;

import com.sun.tools.javac.util.Pair;

import occasion.event.Event;
import occasion.event.Location;
import occasion.account.Post;

import occasion.db.Database;

public class User {
	
	private int userID;
	private String username;
	private String nickname;
	private String email;
	private String gender;
	private String phone;
	private String image;
	private Date birthday;
	private Date registrationDate;
	private boolean premium;
	private int points;
	private int status; 	
	private ArrayList<User> blockedFriendlist;
	private ArrayList<User> hideFriendlist;
	private ArrayList<Event> createdEvent;
	private ArrayList<Event> attendedEvent;
	private ArrayList<Event> futureEvent;
	private TreeSet<String> preferenceType;
	private int preferenceDistance;
	private Location curr_Loc;
			
	public User(List<String> record) {
		
		this.setUserID(Integer.parseInt(record.get(0)));
		this.setUsername(record.get(1));
		this.setNickname(record.get(3));
		this.setPremium(Boolean.parseBoolean(record.get(4)));
		this.setEmail(record.get(5));
		this.setGender(record.get(6));
		this.setPhone(record.get(7));
		this.setImage(record.get(8));
		
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		try {
			this.setBirthday(formatter.parse(record.get(9)));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		try {
			this.setPoints(Integer.parseInt(record.get(10)));
		} catch (Exception e) {
			this.setPoints(0);
		}
		
		try {
			this.setPoints(Integer.parseInt(record.get(11)));
		} catch (Exception e) {
			this.setStatus(0);
		}
	}
	
	public User(String username) {
		String query = "SELECT * FROM User WHERE Username = ?";
		
		List<List<String>> details = Database.SelectQuery(query, username);
		
		if(details.size() == 0) return;
		
		List<String> record = details.get(0);

		this.setUserID(Integer.parseInt(record.get(0)));
		this.setUsername(record.get(1));
		this.setNickname(record.get(3));
		this.setPremium(Boolean.parseBoolean(record.get(4)));
		this.setEmail(record.get(5));
		this.setGender(record.get(6));
		this.setPhone(record.get(7));
		this.setImage(record.get(8));
		
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		try {
			this.setBirthday(formatter.parse(record.get(9)));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		try {
			this.setPoints(Integer.parseInt(record.get(10)));
		} catch (Exception e) {
			this.setPoints(0);
		}
		
		try {
			this.setPoints(Integer.parseInt(record.get(11)));
		} catch (Exception e) {
			this.setStatus(0);
		}
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getImage() {
		if(image == null) return "images/placeholder-person.jpg";
		if(image.equals("")) return "images/placeholder-person.jpg";
		
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public Date getRegistrationDate() {
		return registrationDate;
	}

	public void setRegistrationDate(Date registrationDate) {
		this.registrationDate = registrationDate;
	}

	public boolean isPremium() {
		return premium;
	}

	public void setPremium(boolean premium) {
		this.premium = premium;
	}

	public int getPoints() {
		return points;
	}

	public void setPoints(int points) {
		this.points = points;
	}
	
	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	

	public ArrayList<User> getFollowerList(){
		//Add users which are following this user 
		String query = "SELECT * FROM User, Relationship WHERE FollowingUserID = User.ID AND FollowingUserID = ?";
		List<List<String>> details = Database.SelectQuery(query, Integer.toString(this.getUserID()));
				
		ArrayList<User> follower = new ArrayList<User>();
				
		for(List<String> item : details) {
			follower.add(new User(item));
		}
		return follower; 
	}
	

	public ArrayList<User> getFollowingList(){
		//Add users which this user is following
		String query = "select * from User where UserID in (select FollowingUserID from Relationship where FollowerUserID = ?);";

		List<List<String>> details = Database.SelectQuery(query, Integer.toString(this.getUserID()));
				
		ArrayList<User> following = new ArrayList<User>();
				
		for(List<String> item : details) {
			following.add(new User(item));
		}
		return following;
	}
	
	public ArrayList<User> getBlockedFriendlist(){
		String query = "SELECT * FROM User, Relationship WHERE Relationship.BlockCode = 3 AND Relationship.FollowerUserID = ? AND Relationship.FollowerUserID = User.UserID";
		List<List<String>> result = Database.SelectQuery(query, Integer.toString(this.userID));
		
		ArrayList<User> block_users = new ArrayList<User>();
		for(List<String> record : result) {
			block_users.add(new User(record));
		}
		return block_users;
	}
	public void AddBlockedFriendlist(User U) {
		blockedFriendlist.add(U);
	}

	public ArrayList<User> getHideFriendlist(){
		return hideFriendlist;
	}
	public void AddHideFriendlist(User U) {
		hideFriendlist.add(U);
	}
	
	
	public ArrayList<Event> getCreatedEvent(){
		String query = "select * from Event where HostID = ?;";

		List<List<String>> details = Database.SelectQuery(query, Integer.toString(this.getUserID()));
				
		ArrayList<Event> created = new ArrayList<Event>();
				
		for(List<String> item : details) {
			created.add(new Event(item));
		}
		return created;
	}
	
	public void AddCreatedEvent(Event E) {
		createdEvent.add(E);
	}
	public ArrayList<Event> getAttendedEvent(){
		String query = "SELECT * FROM Event WHERE EventID IN (select EventID from Attendance WHERE UserID = ? AND RSVPStatus = '2');";
		
		List<List<String>> details = Database.SelectQuery(query, Integer.toString(this.userID));
				
		ArrayList<Event> invited = new ArrayList<Event>();
				
		for(List<String> item : details) {
			invited.add(new Event(item));
		}
		
		return invited;
	}
	
		

	public ArrayList<Event> getFutureEvent(){
		String query = "SELECT * FROM Event WHERE EventID IN (select EventID from Attendance WHERE UserID = ? AND RSVPStatus = '2');";

		List<List<String>> details = Database.SelectQuery(query, Integer.toString(this.getUserID()));
				
		ArrayList<Event> future = new ArrayList<Event>();
				
		for(List<String> item : details) {
			future.add(new Event(item));
		}
		return future;
	}
	public void AddFutureEvent(Event E) {
		futureEvent.add(E);
	}
	
	public Set<Event> getRecommendedEvents() {
		String query = "SELECT * from Event WHERE EventID NOT IN (SELECT EventID FROM Attendance WHERE UserID = ? );";

		List<List<String>> details = Database.SelectQuery(query, Integer.toString(this.userID));
			
		Map<String, Double> preferences = new HashMap<String, Double>(); 
		
		query = "SELECT Type FROM Event WHERE EventID IN (SELECT EventID FROM Attendance WHERE UserID = ? AND RSVPStatus = 2)";
		
		List<List<String>> pref_List = Database.SelectQuery(query, Integer.toString(this.userID));
		
		for(List<String> item : pref_List) {
			double count = preferences.containsKey(item.get(0)) ? preferences.get(item.get(0)) : 0;
			preferences.put(item.get(0), count + 1);
		}
		
		for (Map.Entry<String,Double> entry : preferences.entrySet()) {
			preferences.compute(entry.getKey(), (key, val) -> (val = val / pref_List.size()));
		}			
		
		PriorityQueue<Node> queue = new PriorityQueue<>(new NodeComparator());
		
		for(List<String> item : details) {
			Event event = new Event(item);
			Double score = preferences.get(event.getType());
			
			if(score == null) queue.add(new Node(event, 0));
			else queue.add(new Node(event, score.intValue()));			
		}

		Set<Event> recommendSet = new HashSet<Event>(); 

		for(int i = 0; i < Math.max(queue.size(), 10); i++) {
			if(queue.peek() != null) {
				System.out.println(queue.peek().key.getEventName() + " " + queue.peek().value);
				recommendSet.add(queue.peek().key);
				queue.remove();
			}
		}
		return recommendSet;
	}
	
	class Node{
		public int value;
	    public Event key;
	        
	    public Node(Event key, int v){
	    	this.value = v;
	        this.key = key;
	    }
	  }
	  
	  class NodeComparator implements Comparator<Node>{
	        public int compare(Node a, Node b){
	            return (b.value -a.value);
	        }
	   }
	  
	//Placeholder Replace
	public ArrayList<Event> getInvitedEvents() {
		String query = "SELECT * FROM Event WHERE EventID IN (select EventID from Attendance WHERE UserID = ? AND RSVPStatus = '1');";
		
		List<List<String>> details = Database.SelectQuery(query, Integer.toString(this.userID));
				
		ArrayList<Event> invited = new ArrayList<Event>();
				
		for(List<String> item : details) {
			invited.add(new Event(item));
		}
		
		return invited;
	}

	public TreeSet<String> getPreferenceType(){
		return preferenceType;
	}

	public int getPreferenceDistance() {
		return preferenceDistance;
	}

	public Location getLocation() {
		return curr_Loc;
	}

	public ArrayList<Post> getPost(){
		List<List<String>> posts = Database.SelectQuery("SELECT * FROM Post WHERE UserID = ?", Integer.toString(this.userID));
		ArrayList<Post> postList = new ArrayList<Post>();
		for(List<String> post : posts) {
			postList.add(new Post(post));
		}
		return postList;
	}
	
	public ArrayList<Post> getFriendPost(){
		List<List<String>> posts = Database.SelectQuery("SELECT * FROM Post WHERE UserID IN (SELECT FollowingUserID FROM Relationship WHERE FollowerUserID = ?)", Integer.toString(this.userID));
		ArrayList<Post> postList = new ArrayList<Post>();
		for(List<String> post : posts) {
			postList.add(new Post(post));
		}
		return postList;
	}	
	public static String getUsernameFromId(int id) {
		String query = "SELECT username FROM User Where userID = ?";
		
		List<List<String>> results = Database.SelectQuery(query, Integer.toString(id));
		
		return results.get(0).get(0);
	}
	
	public void PrintDetails() {
		System.out.println("Username: " + getUsername());
		System.out.println("Nickname: " + getNickname());
		System.out.println("Email: " + getEmail());
	}
	
}

