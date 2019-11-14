package occasion.account;

import java.util.ArrayList;
import java.util.Date;

import occasion.account.User;

public class Comment {
	
	private int commentID;
	private String line;
	private User sender;
	private User receiver;
	private ArrayList<User> mentioned_Users;
	private Date published_Date;
	private int likes;
	
	public Comment() {
		
	}
}
