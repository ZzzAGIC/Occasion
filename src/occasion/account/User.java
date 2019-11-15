package occasion.account;

import java.text.ParseException;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TreeSet;

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
	private ArrayList<User> followingList;
	private ArrayList<User> followerList;
	private int followingNum;
	private int followerNum;
	private ArrayList<User> blockedFriendlist;
	private ArrayList<User> hideFriendlist;
	private ArrayList<Event> attendedEvent;
	private ArrayList<Event> futureEvent;
	private TreeSet<String> preferenceType;
	private int preferenceDistance;
	private Location curr_Loc;
	private ArrayList<Post> sharedPost;
		
	
	public User() {
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
		
		System.out.println(record.get(9));
        SimpleDateFormat formatter = new SimpleDateFormat("dd-MMM-yyyy");
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
		
		//Add users which are following this user 
		query = "SELECT User.username FROM User, Relationship WHERE FollowingUserID = User.ID AND FollowingUserID = ?";
		details = Database.SelectQuery(query, Integer.toString(this.getUserID()));
		
		ArrayList<User> follower = new ArrayList<User>();
		
		for(List<String> item : details) {
			String itemUsername = item.get(0);
			follower.add(new User(itemUsername));
		}
		this.followerList = follower;
		this.followerNum = followerList.size(); 
		
		//Add users which this user is following
		query = "SELECT User.username FROM User, Relationship WHERE FollowerUserID = User.ID AND FollowerUserID = ?";
		details = Database.SelectQuery(query, Integer.toString(this.getUserID()));
		
		ArrayList<User> following = new ArrayList<User>();
		
		for(List<String> item : details) {
			String itemUsername = item.get(0);
			following.add(new User(itemUsername));
		}
		this.followingList = following;
		this.followingNum = followingList.size();
		
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
	

	public ArrayList<User> getFollowingList(){
		return followingList;
	}
	public void AddFollowingList(User U) {
		followingList.add(U);
	}

	public ArrayList<User> getFollowerList(){
		return followerList;
	}
	public void AddFollowerList(User U) {
		followerList.add(U);
	}

	public int getFollowingNume() {
		return followingList.size();
	}

	public int getFollowerNume() {
		return followerList.size();
	}

	public ArrayList<User> getBlockedFriendlist(){
		return blockedFriendlist;
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
	
	
	public ArrayList<Event> getAttendedEvent(){
		return attendedEvent;
	}
	public void AddAttendedEvent(Event E) {
		attendedEvent.add(E);
	}
	
	public ArrayList<Event> getFutureEvent(){
		return futureEvent;
	}
	public void AddFutureEvent(Event E) {
		futureEvent.add(E);
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
		return sharedPost;
	}
	public void AddPost(Post P) {
		sharedPost.add(P);
	}
	

	public void PrintDetails() {
		System.out.println("Username: " + getUsername());
		System.out.println("Nickname: " + getNickname());
		System.out.println("Email: " + getEmail());
	}
}
