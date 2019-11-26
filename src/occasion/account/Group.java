package occasion.account;

import java.util.ArrayList;
import java.util.List;

import occasion.db.Database;

public class Group {
	private String GroupID;
	private String GroupName;
	private User Owner;
	private ArrayList<User> members;
	private int size;
	private String Picture;
	private String description;
	
	public Group() {
		
	}
	
	public Group(String GroupID) {
		String query = "SELECT * FROM FriendGroup WHERE GroupID = ?";
		
		List<List<String>> details = Database.SelectQuery(query, GroupID);
		
		if(details.size() == 0) return;
		
		List<String> record = details.get(0);
	}
	public void setID(String id) {
		GroupID = id;
	}
	public String getID() {
		return GroupID;
	}
	public void setGroupName(String name) {
		GroupName = name;
	}
	public String getGroupName() {
		return GroupName;
	}
	public void setOwner(User u) {
		Owner = u;
	}
	public User getOwner() {
		return Owner;
	}
	public ArrayList<User> getMembers() {
		String query = "SELECT U.username FROM User U, GroupUser G WHERE U.UserID = G.UserID AND GroupID = ?";
		List<List<String>> details = Database.SelectQuery(query,this.getID());
				
		ArrayList<User> members = new ArrayList<User>();
				
		for(List<String> item : details) {
			String itemUsername = item.get(0);
			members.add(new User(itemUsername));
		}
		return members; 
	}
	
	public void setSize(int s) {
		size = s;
	}
	public int getSize() {
		return size;
	}
	public void setPicture(String img) {
		Picture = img;
	}
	public String getPicture() {
		return Picture;
	}
	public void setDescription(String d) {
		description = d;
	}
	public String getDescription() {
		return description;
	}
	
	
}
