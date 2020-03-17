import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.sun.javafx.fxml.builder.URLBuilder;

public class weatherTest {

	
	
	public static void main(String[] args){
		String apiUrl = "http://api.openweathermap.org/data/2.5/weather"
				+ "?lat=35.124"
				+ "&lon=126.8031"
				+ "&appid=a79479d2d982619acbd0468021a88e8f";
		
		StringBuilder urlBuilder = new StringBuilder(apiUrl);
		
		try {
			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
			
			BufferedReader rd;
			
			if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			    rd = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
			} else {
			    rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(),"UTF-8"));
			}
			
			StringBuilder sb = new StringBuilder();
			String line;
			String totalStr = "";
			
			while ((line = rd.readLine()) != null) {
			    sb.append(line);
			}
			
			conn.disconnect();
			System.out.println(sb.toString());
			
			totalStr = sb.toString();
			JSONParser parser 	= new JSONParser();
			JSONObject total 	= (JSONObject) parser.parse(totalStr);
			JSONArray weather = (JSONArray) total.get("weather");
			JSONObject arrIdx 	= (JSONObject) weather.get(0);
			String icon 	= (String) arrIdx.get("icon");
			System.out.println(icon);
			
			
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (ProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		
		
	}
	
	
}
