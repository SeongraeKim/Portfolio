package com.ode.airplane;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;


public class airplaneService {
	
	/* 공공데이터포털 인증키 */
	final String key = "qUcTXdjOpu4%2Fp2%2BpA6k7e8clCyoVk%2Bk3EAx8O41%2FQ3AjrpoSSC0M7jr6wxG%2BMErlQlgANMZHEhQmdsDbrqargA%3D%3D";

	/*	-------------------------------------------------------------------------
		|	공항명		|  IATA코드	|	    공항ID		|		      위도 & 경도	 		|
	 	-------------------------------------------------------------------------
		|	  김포		|	 GMP	|	 NAARKSS	|	lat=37.561&lon=126.801	|
		|	  인천		|	 ICN	|	 NAARKSI	|	lat=37.464&lon=126.441	|
		|	  김해		|	 PUS	|	 NAARKPK	|	lat=35.180&lon=128.936	|
		|	  제주		|	 CJU	|	 NAARKPC	|	lat=33.506&lon=126.491	|
		|	  청주		|	 CJJ	|	 NAARKTU	|	lat=36.715&lon=127.496	|
		|	  무안		|	 MWX	|	 NAARKJB	|	lat=34.993&lon=126.386	|
		|	  광주		|	 KJW	|	 NAARKJJ	|	lat=35.124&lon=126.803	|
		|	  군산		|	 KUV	|	 NAARKJK	|	lat=35.907&lon=126.622	|
		|	  여수		|	 RSU	|	 NAARKJY	|	lat=34.842&lon=127.616	|
		|	  원주		|	 WJU	|	 NAARKNW	|	lat=37.439&lon=127.966	|
		|	  양양		|	 YNY	|	 NAARKNY	|	lat=38.059&lon=128.667	|
		|	  울산		|	 USN	|	 NAARKPU	|	lat=35.593&lon=129.352	|
		|	  포항		|	 KPO	|	 NAARKTH	|	lat=35.986&lon=129.422	|
		|    대구		|	 TAE	|	 NAARKTN	|	lat=35.896&lon=128.656	|
		|    사천		|	 HIN	|	 NAARKPS	|	lat=35.089&lon=128.067	|
		------------------------------------------------------------------------	*/
	
	Map<String, String> map = new HashMap<String, String>();
	{
		/* 공항 ID -> 공항 IATA */
		map.put("NAARKSS", "GMP");	// 김포공항
		map.put("NAARKSI", "ICN");	// 인천공항
		map.put("NAARKPK", "PUS");	// 김해공항
		map.put("NAARKPC", "CJU");	// 제주공항
		map.put("NAARKTU", "CJJ");	// 청주공항
		map.put("NAARKJB", "MWX");	// 무안공항
		map.put("NAARKJJ", "KJW");	// 광주공항
		map.put("NAARKJK", "KUV");	// 군산공항
		map.put("NAARKJY", "RSU");	// 여수공항
		map.put("NAARKNW", "WJU");	// 원주공항
		map.put("NAARKNY", "YNY");	// 양양공항
		map.put("NAARKPU", "USN");	// 울산공항
		map.put("NAARKTH", "KPO");	// 포항공항
		map.put("NAARKTN", "TAE");	// 대구공항
		map.put("NAARKPS", "HIN");	// 사천공항
	}
	
	Map<String, String> map2 = new HashMap<String, String>();
	{
		/* 공항 ID -> 공항위치(위도&경도) */
		map.put("김포", "lat=37.561&lon=126.801");	// 김포공항
		map.put("인천", "lat=37.464&lon=126.441");	// 인천공항
		map.put("김해", "lat=35.180&lon=128.936");	// 김해공항
		map.put("제주", "lat=33.506&lon=126.491");	// 제주공항
		map.put("청주", "lat=36.715&lon=127.496");	// 청주공항
		map.put("무안", "lat=34.993&lon=126.386");	// 무안공항
		map.put("광주", "lat=35.124&lon=126.803");	// 광주공항
		map.put("군산", "lat=35.907&lon=126.622");	// 군산공항
		map.put("여수", "lat=34.842&lon=127.616");	// 여수공항
		map.put("원주", "lat=37.439&lon=127.966");	// 원주공항
		map.put("양양", "lat=38.059&lon=128.667");	// 양양공항
		map.put("울산", "lat=35.593&lon=129.352");	// 울산공항
		map.put("포항", "lat=35.986&lon=129.422");	// 포항공항
		map.put("대구", "lat=35.896&lon=128.656");	// 대구공항
		map.put("사천", "lat=35.089&lon=128.067");	// 사천공항
	}
	
	public List<Map<String, Object>> airportParkCheck(String depAirportNm) {
		
		String result = map.get(depAirportNm);	// 공항명에 해당하는 IATA 공항코드 값 가져오기
		List<Map<String,Object>> parkList = new ArrayList<Map<String,Object>>();
		StringBuilder sb = null;
		
		try {
			StringBuilder urlBuilder = new StringBuilder("http://openapi.airport.co.kr/service/rest/AirportParking/airportparkingRT"); 	// URL
			urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + key); 												// 인증키
			urlBuilder.append("&" + URLEncoder.encode("schAirportCode","UTF-8") + "=" + URLEncoder.encode("GMP", "UTF-8"));  			// 공항명
			urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); 					// 변환TYPE
			
			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
			// System.out.println("Response code: " + conn.getResponseCode()); // 응답코드 출력
			BufferedReader rd;
			
			if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			    rd = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
			} else {
			    rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(),"UTF-8"));
			}
			
			sb = new StringBuilder();
			String line;
			String totalStr = "";
			
			while ((line = rd.readLine()) != null) {
			    sb.append(line);
			}
			
			rd.close();
			conn.disconnect();
			// System.out.println(sb.toString()); // JSON데이터 출력
			
			// JSON데이터 파싱 (response - body - items -item)
			totalStr = sb.toString();
			JSONParser parser 	= new JSONParser();
			JSONObject total 	= (JSONObject) parser.parse(totalStr);
			JSONObject response = (JSONObject) total.get("response");
			JSONObject body 	= (JSONObject) response.get("body");
			JSONObject items 	= (JSONObject) body.get("items");
			JSONArray  item 	= (JSONArray)  items.get("item");
			
			for(int i = 0 ; i < item.size() ; i++){
				
				JSONObject col = (JSONObject) item.get(i);
				String 	parkingAirportCodeName 	= (String) 	col.get("parkingAirportCodeName");	// 주차장명
				Long	parkingFullSpace 		= (Long) 	col.get("parkingFullSpace");		// 총주차공간
				String 	parkingGetdate			= (String) 	col.get("parkingGetdate");			// 업데이트일자
				String 	parkingGettime 			= (String) 	col.get("parkingGettime");			// 업데이트시간
				Long 	parkingIstay 			= (Long) 	col.get("parkingIstay");			// 현재 주차수
			
				Map<String,Object> colMap = new HashMap<String,Object>();
				
				colMap.put("parkingAirportCodeName", parkingAirportCodeName);
				colMap.put("parkingFullSpace", parkingFullSpace);
				colMap.put("parkingIstay", parkingIstay);
				colMap.put("parkingIempty", parkingFullSpace - parkingIstay);
				colMap.put("parkingGetdate", parkingGetdate);
				colMap.put("parkingGettime", parkingGettime);
				
				parkList.add(colMap);
			}
			
			
		} catch (UnsupportedEncodingException e) {
			System.out.println("주차장 메서드 에러 EncodingException"+ e);
		} catch (MalformedURLException e) {
			System.out.println("주차장 메서드 에러 MalformedURLException"+ e);
		} catch (ProtocolException e) {
			System.out.println("주차장 메서드 에러 ProtocolException"+ e);
		} catch (IOException e) {
			System.out.println("주차장 메서드 에러 IOException"+ e);
		} catch (ParseException e) {
			System.out.println("주차장 메서드 에러 ParseException"+ e);
		}
		
		return parkList;
	}

	public List<Map<String,Object>>  airplaneSearch(String depAirport, String arrAirport, String depTime) {
		
		List<Map<String,Object>> airlineList = new ArrayList<Map<String,Object>>();
		StringBuilder sb = null;

		try {
			
			StringBuilder urlBuilder = new StringBuilder("http://openapi.tago.go.kr/openapi/service/DmstcFlightNvgInfoService/getFlightOpratInfoList"); // URL
			urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + key); 											// 인증키
			urlBuilder.append("&" + URLEncoder.encode("depAirportId","UTF-8") + "=" + URLEncoder.encode(depAirport, "UTF-8")); 		// 출발공항ID
			urlBuilder.append("&" + URLEncoder.encode("arrAirportId","UTF-8") + "=" + URLEncoder.encode(arrAirport, "UTF-8")); 		// 도착공항ID
			urlBuilder.append("&" + URLEncoder.encode("depPlandTime","UTF-8") + "=" + URLEncoder.encode(depTime, "UTF-8")); 		// 출발일
			urlBuilder.append("&" + "_type=json");
			
			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
			System.out.println("Response code: " + conn.getResponseCode());
			BufferedReader rd;
			if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			    rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			} else {
			    rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
			}
			sb = new StringBuilder();
			String line;
			String totalStr;
			while ((line = rd.readLine()) != null) {
					sb.append(line);	
			}
			
			// JSON데이터 파싱 (response - body - items -item)
			totalStr = sb.toString();
			JSONParser parser 	= new JSONParser();
			JSONObject total 	= (JSONObject) parser.parse(totalStr);
			JSONObject response = (JSONObject) total.get("response");
			JSONObject body 	= (JSONObject) response.get("body");
			JSONObject items 	= (JSONObject) body.get("items");
			JSONArray item 		= (JSONArray) items.get("item");
			
			for(int i = 0 ; i < item.size() ; i++){
				
				JSONObject col = (JSONObject) item.get(i);
				String airlineNm 	= (String) col.get("airlineNm");		// 항공사명
				String depAirportNm = (String) col.get("depAirportNm");		// 출발공항
				Long depPlandTime 	= (Long) col.get("depPlandTime");		// 출발시간
				String arrAirportNm = (String) col.get("arrAirportNm");		// 도착공항
				Long arrPlandTime	= (Long) col.get("arrPlandTime");		// 도착시간
				Long economyCharge	= (Long) col.get("economyCharge");		// 운임
				String vihicleId	= (String) col.get("vihicleId");		// 항공편명
				
				Map<String,Object> colMap = new HashMap<String,Object>();
				
				colMap.put("airlineNm", airlineNm);
				colMap.put("depAirportNm", depAirportNm);
				colMap.put("depPlandTime", depPlandTime);
				colMap.put("arrAirportNm", arrAirportNm);
				colMap.put("arrPlandTime", arrPlandTime);
				colMap.put("economyCharge", economyCharge);
				colMap.put("vihicleId", vihicleId);
				
				airlineList.add(colMap);
			}
			rd.close(); 
			conn.disconnect();
			System.out.println(sb.toString());
			
		} catch (UnsupportedEncodingException e) {
			System.out.println("항공권 조회 메서드 에러 EncodingException"+ e);
		} catch (MalformedURLException e) {
			System.out.println("항공권 조회 메서드 에러 MalformedURLException"+ e);
		} catch (ProtocolException e) {
			System.out.println("항공권 조회 메서드 에러 ProtocolException"+ e);
		} catch (IOException e) {
			System.out.println("항공권 조회 메서드 에러 IOException"+ e);
		} catch (ParseException e) {
			System.out.println("항공권 조회 메서드 에러 ParseException"+ e);
		}	
		
		return airlineList;
	}
	
	public String airportWeather(String depAirportNm){
		
		String result = map2.get(depAirportNm);
		// System.out.println("출발공항 : " + depAirportNm);
		// System.out.println("위도 경도 : " + result);
		String apiUrl = "http://api.openweathermap.org/data/2.5/weather?" + 	// URL
						"&lat=35&lon=129" + 									// 위도&경도
						"&appid=a79479d2d982619acbd0468021a88e8f";				// 인증키
		
		String icon = null;
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
			
			// JSON데이터 파싱 (weather - 0)
			totalStr = sb.toString();
			JSONParser parser 	= new JSONParser();
			JSONObject total 	= (JSONObject) parser.parse(totalStr);
			JSONArray  weather 	= (JSONArray)  total.get("weather");
			JSONObject arrIdx 	= (JSONObject) weather.get(0);
			icon 	= (String) arrIdx.get("icon");
			System.out.println(icon);
			
			
		} catch (MalformedURLException e) {
			System.out.println("날씨조회 메서드 에러 MalformedURLException"+ e);
		} catch (ProtocolException e) {
			System.out.println("날씨조회 메서드 에러 ProtocolException"+ e);
		} catch (IOException e) {
			System.out.println("날씨조회 메서드 에러 IOException"+ e);
		} catch (ParseException e) {
			System.out.println("날씨조회 메서드 에러 ParseException"+ e);
		}
		
		return icon;
	}
	
	public List<Map<String,Object>>  airportWeather2(String depAirport) {
		
		List<Map<String,Object>> weather = new ArrayList<Map<String,Object>>();

		
		return null;
	}
	
}



