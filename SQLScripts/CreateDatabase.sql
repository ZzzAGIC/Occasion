CREATE DATABASE EventProject;

USE EVENT;

CREATE TABLE User {
	UserID INT(11) PRIMARY KEY not null AUTO_INCREMENT,
	Username VARCHAR(50),
	Password VARCHAR(50),
	Salt VARCHAR(50),
	Premium BOOLEAN,
	Email VARCHAR(50),
	Gender BOOLEAN,
	Phone INT(13),
	ProfileImage VARCHAR(50),
	Birthday DATE,
	Points INT(5),
	Status INT(2)
};

CREATE TABLE PasswordRecovery {
	RecoverID INT(11) PRIMARY KEY not null AUTO_INCREMENT,
	UserID INT(11).
	Token VARCHAR(50),
	FOREIGN KEY UserID REFERENCES User(UserID)
}

CREATE TABLE Event {
	EventID INT(11) PRIMARY KEY not null AUTO_INCREMENT,
	Name VARCHAR(50),
	EventDate DATE,
	LocationID INT(11),
	Type VARCHAR(50),
	Picture VARCHAR(50),
	HostID INT(11),
	Capacity INT(11),
	Size INT(11),
	Price INT(5),
	Description VARCHAR(200),
	FOREIGN KEY HostID REFERENCES User(UserID)
	FOREIGN KEY LocationID REFERENCES Location(LocationID)
};

CREATE TABLE Attendance {
	AttendanceID INT(11) PRIMARY KEY not null AUTO_INCREMENT,
	EventID INT(11),
	UserID INT(11),
	RSVPStatus INT(1),
	Favourite INT(1),
	FOREIGN KEY EventID REFERENCES Event(EventID),
	FOREIGN KEY UserID REFERENCES User(UserID)
};

CREATE TABLE Group {
	GroupID INT(11) PRIMARY KEY not null AUTO_INCREMENT,
	GroupName VARCHAR(50),
	Picture VARCHAR(50),
	Description VARCHAR(200),
	OwnerID INT(11),
	Size INT(5),
	FOREIGN KEY OwnerID REFERENCES User(UserID)
};

CREATE TABLE GroupUser {
	GroupUserID INT(11) PRIMARY KEY not null AUTO_INCREMENT,
	GroupID INT(11),
	UserID INT(11),
	Description VARCHAR(200),
	FOREIGN KEY GroupID REFERENCES Group(GroupID),
	FOREIGN KEY UserID REFERENCES User(UserID)	
};

CREATE TABLE Relationship {
	RelationshipID INT(11) PRIMARY KEY not null AUTO_INCREMENT,
	AlphaUserID INT(11),
	BetaUserID INT(11),
	ActionUserID INT(11),
	StatusCode INT(1),
	BlockCode INT(1),
	FOREIGN KEY AlphaUserID REFERENCES User(UserID),
	FOREIGN KEY BetaUserID REFERENCES User(UserID),
	FOREIGN KEY ActionUserID REFERENCES User(UserID)	
};

CREATE TABLE Chat {
	MessageID INT(11) PRIMARY KEY not null AUTO_INCREMENT,
	Message VARCHAR(200),
	SenderID INT(11),
	ReceiverID INT(11),
	FOREIGN KEY SenderID REFERENCES User(UserID),
	FOREIGN KEY ReceiverID REFERENCES User(UserID)	
};

CREATE TABLE PostID {
	PostID INT(11) PRIMARY KEY not null AUTO_INCREMENT,
	EventID INT(11),
	UserID INT(11),
	Like INT(11),
	Description VARCHAR(200),
	FOREIGN KEY UserID REFERENCES User(UserID),
	FOREIGN KEY EventID REFERENCES Event(EventID)	
};

CREATE TABLE Preferences {
	PreferenceID INT(11) PRIMARY KEY not null AUTO_INCREMENT,
	UserID INT(11),
	TypeID INT(11),
	FOREIGN KEY UserID REFERENCES User(UserID),
	FOREIGN KEY TypeID REFERENCES Type(UserID),
};

CREATE TABLE Location {
	LocationID INT(11) PRIMARY KEY not null AUTO_INCREMENT,
	City VARCHAR(11),
	Country VARCHAR(11),
	State VARCHAR(11),
	Street VARCHAR(200),
	Zipcode INT(11),
	Longitude VARCHAR(20),
	Latitude VARCHAR(20)
};