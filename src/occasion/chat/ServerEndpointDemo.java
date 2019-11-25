package occasion.chat;

import java.io.IOException;
import java.io.StringWriter;
import java.util.*;
import javax.json.*;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/serverendpointdemo")
public class ServerEndpointDemo {
	static Set<Session> chatroomUsers = Collections.synchronizedSet(new HashSet<Session>());
	
	@OnOpen
	public void handleOpen(Session userSession) {
		chatroomUsers.add(userSession);
		System.out.println("Client is now connected");
		System.out.println("Client2222222222222222222");
	}
	@OnMessage
	public void handleMessage(String message, Session userSession) throws IOException{
		System.out.println("Message to be handled= " + message);
		String username = (String) userSession.getUserProperties().get("username");
		if(username == null) {
			userSession.getUserProperties().put("username",  message);
			userSession.getBasicRemote().sendText(buildJsonData("System","You are now connected as " + message));
		} else {
			Iterator<Session> iterator = chatroomUsers.iterator();
			while(iterator.hasNext()) iterator.next().getBasicRemote().sendText(buildJsonData(username, message));
		}
	}
	@OnClose
	public void handleClose(Session userSession) {
		chatroomUsers.remove(userSession);
		System.out.println("Client is now disconnected");
	}
	@OnError 
	public void handleError(Throwable t) {
		t.printStackTrace();
	}
	
	private String buildJsonData(String username, String message) {
		JsonObject jsonObject = Json.createObjectBuilder().add("message", username+": " + message).build();
		StringWriter sw = new StringWriter();
		try (JsonWriter jsonWriter = Json.createWriter(sw)) {jsonWriter.write(jsonObject);}
		return sw.toString();
	}
}