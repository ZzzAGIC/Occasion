package occasion.chat;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Vector;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class ChatRoom {

	private Vector<ServerThread> serverThreads;
	private Vector<Lock> locks;
	private Vector<Condition> conditions;
	
	public ChatRoom(int port) {
		try {
			System.out.println("Binding to port " + port);
			ServerSocket ss = new ServerSocket(port);
			System.out.println("Bound to port " + port);
			this.serverThreads = new Vector<ServerThread>();
			this.locks = new Vector<Lock>();
			this.conditions = new Vector<Condition>();
			
			while(true) {
				Socket s = ss.accept(); // blocking
				System.out.println("Connection from: " + s.getInetAddress());
				Lock lock = new ReentrantLock();
				Condition condition = lock.newCondition();
				ServerThread st = new ServerThread(s, this, condition, lock,serverThreads.isEmpty());
				serverThreads.add(st);
				locks.add(lock);
				conditions.add(condition);
			}
		} catch (IOException ioe) {
			System.out.println("ioe in ChatRoom constructor: " + ioe.getMessage());
		}
	}
	
	public void broadcast(String message, ServerThread st) {
		if (message != null) {
			System.out.println(message);
			for(ServerThread threads : serverThreads) {
				if (st != threads) {
					threads.sendMessage(message);
				}
			}
		}
	}
	
	public void signal(ServerThread st) {
		if(this.serverThreads.size() == 1)
		{
			locks.elementAt(0).lock();
			conditions.elementAt(0).signal();
			locks.elementAt(0).unlock();
		}
		
		int index = this.serverThreads.indexOf(st) + 1;
		if (index == this.serverThreads.size()) {
			index = 0;
		}
		locks.elementAt(index).lock();
		conditions.elementAt(index).signal();
		locks.elementAt(index).unlock();
	}
	
	public static void main(String [] args) {
		ChatRoom cr = new ChatRoom(6789);
	}
}
