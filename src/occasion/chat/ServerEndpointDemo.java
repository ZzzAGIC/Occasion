package occasion.chat;

import java.io.IOException;
import java.util.*;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint(value = "/ws")
public class ServerEndpointDemo {
	private static Vector<Session> sessionVector = new Vector<Session>();
	
	@OnOpen
	public void open(Session session) {
		System.out.println("Connection made!");
		sessionVector.add(session);
	}
	@OnMessage
	public void onMessage(String message, Session userSession) {
		System.out.println(message);
		try {
			for(Session s : sessionVector) {
				s.getBasicRemote().sendText(message);
			}
		} catch (IOException ioe) {
			System.out.println( "ioe: " + ioe.getMessage());
			close(userSession);
		}

	}
	@OnClose
	public void close(Session userSession) {
		System.out.println("Disconnecting");
		sessionVector.remove(userSession);
	}
	@OnError 
	public void handleError(Throwable t) {
		System.out.println("Error!");
	}
	
}