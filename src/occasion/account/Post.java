package occasion.account;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import occasion.account.Comment;
import occasion.account.User;
import occasion.db.Database;
import occasion.event.Event;

public class Post {
	private String postID;
	private String post_text;
	private ArrayList<String> pictures;
	private ArrayList<User> visible_Users;
	private int likes;
	private ArrayList<Comment> comments;
	private ArrayList<User> mentioned_users;
	private Date postDate;
	private Event related_Event;
	
	public Post () {
		
	}
	public Post(String postID) {
		String query = "SELECT * FROM Post WHERE PostID = ?";
		
		List<String> result = Database.SelectQuery(query, postID).get(0);
		
	}
	
}
