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
	private String pictures;
	private ArrayList<User> visible_Users;
	private int likes;
	private ArrayList<Comment> comments;
	private ArrayList<User> mentioned_users;
	private Date postDate;
	private Event related_Event;
	
	public Post (List<String> dbRow) {
		postID = dbRow.get(0);
		post_text = dbRow.get(4);
		pictures = dbRow.get(5);
		likes = Integer.parseInt(dbRow.get(3));
	}
	public Post(String postID) {
		
	}
	
	public String getPostID() {
		return postID;
	}
	public void setPostID(String postID) {
		this.postID = postID;
	}
	public String getPost_text() {
		return post_text;
	}
	public void setPost_text(String post_text) {
		this.post_text = post_text;
	}
	public String getPictures() {
		return pictures;
	}
	public void setPictures(String pictures) {
		this.pictures = pictures;
	}
	public ArrayList<User> getVisible_Users() {
		return visible_Users;
	}
	public void setVisible_Users(ArrayList<User> visible_Users) {
		this.visible_Users = visible_Users;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	public ArrayList<Comment> getComments() {
		return comments;
	}
	public void setComments(ArrayList<Comment> comments) {
		this.comments = comments;
	}
	public ArrayList<User> getMentioned_users() {
		return mentioned_users;
	}
	public void setMentioned_users(ArrayList<User> mentioned_users) {
		this.mentioned_users = mentioned_users;
	}
	public Date getPostDate() {
		return postDate;
	}
	public void setPostDate(Date postDate) {
		this.postDate = postDate;
	}
	public Event getRelated_Event() {
		return related_Event;
	}
	public void setRelated_Event(Event related_Event) {
		this.related_Event = related_Event;
	}
	
}
