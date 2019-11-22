package occasion.map;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class Map {
	public static final String APIkey = "AIzaSyBsK1nRM2sfZDiQE7P4MIkxwUrft61TUTw";
	
	public static List<String>  getGeocode(String street, String room, String city, String state,
			String country, String zipcode) throws IOException{
		List<String> output = new ArrayList<String>();
		street = street.replace(" ", "+");
		city = city.replace(" ", "+");
		String mapstring = "https://maps.googleapis.com/maps/api/geocode/json?address="
				+ street +",+"+ city +",+"+ state +"&key="+APIkey;
		System.out.println(mapstring);
		
		URL url = new URL(mapstring);
		URLConnection urlConnection = url.openConnection();
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
		
		String line;
		StringBuilder content = new StringBuilder();
		while( (line = bufferedReader.readLine()) != null) {
			content.append(line);
		}
		bufferedReader.close();
		System.out.println(content.toString());
		

		JsonParser parser = new JsonParser();

		JsonObject job = parser.parse(content.toString()).getAsJsonObject();
		//parser.parse(content.toString()).getAsJsonObject();
		
		JsonArray ja_result = (JsonArray) job.get("results");
		System.out.println(ja_result);
		JsonObject obj_addressCompoment = (JsonObject)ja_result.get(0);
		JsonObject obj_geometry = (JsonObject)obj_addressCompoment.get("geometry");
		JsonObject obj_location = (JsonObject)obj_geometry.get("location");
		
		
		String lat = (obj_location.get("lat")).toString();
		
		String lng = (obj_location.get("lng")).toString();
		
		System.out.println(lat);
		System.out.println(lng);
		
		output.add(lat);
		output.add(lng);
		return output;
	}
}
