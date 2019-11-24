CREATE DATABASE EventProject;

USE EventProject;

CREATE TABLE User (
	UserID INT(11) PRIMARY KEY not null AUTO_INCREMENT,
	Username VARCHAR(50),
	Password VARCHAR(50),
	Salt VARCHAR(50),
	Premium BOOLEAN,
	Email VARCHAR(50),
	Gender VARCHAR(50),
	Phone INT(13),
	ProfileImage VARCHAR(50),
	Birthday DATE,
	Points INT(5),
	Status INT(2)
);

--temporary table for image testing
CREATE TABLE Test (
	TestID INT(11) PRIMARY KEY not null AUTO_INCREMENT,
	img MEDIUMBLOB
);

CREATE TABLE PasswordRecovery (
	RecoverID INT(11) PRIMARY KEY not null AUTO_INCREMENT,
	UserID INT(11).
	Token VARCHAR(50),
	FOREIGN KEY UserID REFERENCES User(UserID)
)

CREATE TABLE Event (
	EventID INT(11) PRIMARY KEY not null AUTO_INCREMENT,
	EventName VARCHAR(50),
	EventDate DATE,
	LocationID INT(11),
	Type VARCHAR(50),
	Picture VARCHAR(200),
	HostID INT(11),
	Capacity INT(11),
	Size INT(11),
	Price INT(5),
	Description VARCHAR(500),
	Privacy INT(1),
	FOREIGN KEY (HostID) REFERENCES User(UserID),
	FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);

CREATE TABLE Attendance (
	AttendanceID INT(11) PRIMARY KEY not null AUTO_INCREMENT,
	EventID INT(11),
	UserID INT(11),
	RSVPStatus INT(1),
	Favourite INT(1),
	FOREIGN KEY EventID REFERENCES Event(EventID),
	FOREIGN KEY UserID REFERENCES User(UserID)
);

CREATE TABLE Group (
	GroupID INT(11) PRIMARY KEY not null AUTO_INCREMENT,
	GroupName VARCHAR(50),
	Picture VARCHAR(50),
	Description VARCHAR(200),
	OwnerID INT(11),
	Size INT(5),
	FOREIGN KEY OwnerID REFERENCES User(UserID)
);

CREATE TABLE GroupUser (
	GroupUserID INT(11) PRIMARY KEY not null AUTO_INCREMENT,
	GroupID INT(11),
	UserID INT(11),
	Description VARCHAR(200),
	FOREIGN KEY GroupID REFERENCES Group(GroupID),
	FOREIGN KEY UserID REFERENCES User(UserID)	
);

CREATE TABLE Relationship (
	RelationshipID INT(11) PRIMARY KEY not null AUTO_INCREMENT,
	FollowerUserID INT(11),
	FollowingUserID INT(11),
	BlockCode INT(1),
	FOREIGN KEY (FollowerUserID) REFERENCES User(UserID),
	FOREIGN KEY (FollowingUserID) REFERENCES User(UserID)
);

CREATE TABLE Chat (
	MessageID INT(11) PRIMARY KEY not null AUTO_INCREMENT,
	Message VARCHAR(200),
	SenderID INT(11),
	ReceiverID INT(11),
	FOREIGN KEY SenderID REFERENCES User(UserID),
	FOREIGN KEY ReceiverID REFERENCES User(UserID)	
);

CREATE TABLE Post (
	PostID INT(11) PRIMARY KEY not null AUTO_INCREMENT,
	EventID INT(11),
	UserID INT(11),
	LikeNum INT(11),
	Description VARCHAR(200),
	FOREIGN KEY (UserID) REFERENCES User(UserID),
	FOREIGN KEY (EventID) REFERENCES Event(EventID)	
);

CREATE TABLE Preferences (
	PreferenceID INT(11) PRIMARY KEY not null AUTO_INCREMENT,
	UserID INT(11),
	TypeID INT(11),
	FOREIGN KEY UserID REFERENCES User(UserID),
	FOREIGN KEY TypeID REFERENCES Type(UserID),
);

CREATE TABLE Location (
	LocationID INT(11) PRIMARY KEY not null AUTO_INCREMENT,
	City VARCHAR(50),
	Country VARCHAR(50),
	State VARCHAR(50),
	Street VARCHAR(200),
	Zipcode VARCHAR(20),
	Longitude VARCHAR(50),
	Latitude VARCHAR(50)
);