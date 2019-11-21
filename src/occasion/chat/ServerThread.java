package occasion.chat;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;

public class ServerThread extends Thread {

	private PrintWriter pw;
	private BufferedReader br;
	private ChatRoom cr;
	private Condition condition;
	private Lock lock;
	private boolean firstThread;

	public ServerThread(Socket s, ChatRoom cr, Condition condition, Lock lock, boolean firstThread) {
		try {
			this.cr = cr;
			this.condition = condition;
			this.lock = lock;
			this.firstThread = firstThread;
			pw = new PrintWriter(s.getOutputStream());
			br = new BufferedReader(new InputStreamReader(s.getInputStream()));
			this.start();
		} catch (IOException ioe) {
			System.out.println("ioe in ServerThread constructor: " + ioe.getMessage());
		}
	}

	public void sendMessage(String message) {
		pw.println(message);
		pw.flush();
	}
	
	public void run() {
		try {
			while(true) {
				lock.lock();
				if(!firstThread) {
					condition.await();
				} else {
					firstThread = false;
				}
				this.sendMessage("your turn");
				String line = br.readLine();
				while(!line.contains("END_OF_MESSAGE")) {
					cr.broadcast(line, this);
					line = br.readLine();
				}
				this.sendMessage("Please wait");
				cr.signal(this);
				lock.unlock();
			}
		} catch(InterruptedException e) {
			System.out.println("InterruptedException in ServerThread.run(): " + e.getMessage());
			e.printStackTrace();
		} catch (IOException ioe) {
			System.out.println("ioe in ServerThread.run(): " + ioe.getMessage());
			ioe.printStackTrace();
		}
	}
}






