package occasion.account;

import java.util.ArrayList;
import java.util.Date;
import occasion.account.Comment;
import occasion.account.User;
import occasion.event.Event;

public class Post {
	private int postID;
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
	
}
