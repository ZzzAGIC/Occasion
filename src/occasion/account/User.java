package occasion.account;

import java.util.Date;
import java.util.List;

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
	
	public User() {
	}
	
	public User(String username) {
		String query = "SELECT * FROM User WHERE Username = ?";
		
		List<List<String>> details = Database.SelectQuery(query, username);
		
		if(details.size() == 0) return;
		
		List<String> record = details.get(0);
		
		this.setUserID(Integer.parseInt(record.get(0)));
		this.setUsername(record.get(1));
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
}
