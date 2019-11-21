package occasion.chat;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/serverendpointdemo")
public class ServerEndpointDemo {
	@OnOpen
	public void handleOpen() {
		System.out.println("Client is now connected");
	}
	@OnMessage
	public String handleMessage(String message) {
		System.out.println("Receive from client: " + message);
		String replyMessage = "echo " + message;
		System.out.println("send to client: " + replyMessage);
		return replyMessage;
	}
	@OnClose
	public void handleClose() {
		System.out.println("Client is now disconnected");
	}
	@OnError 
	public void handleError(Throwable t) {
		t.printStackTrace();
	}
}