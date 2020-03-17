package com.ode.airplane;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.ws.RespectBinding;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

// JSON뷰어	-	http://jsonviewer.stack.hu/

// airplaneSearch.do	->		airplaneList.jsp 
@WebServlet("/airplane/*")
public class airplaneController extends HttpServlet{

	airplaneService airService;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		
		airService = new airplaneService();
		
		String action = request.getPathInfo();
		String viewPage = "";
		
		String depAirportNm = request.getParameter("depAirportNm");
		String arrAirportNm = request.getParameter("arrAirportNm");
		


		try {
			
			if(action.equals("/airplaneSearch.do")){
				String beforeDepPlandTime = request.getParameter("depPlandTime");
				String depPlandTime = beforeDepPlandTime.replace("/", "");

				String beforeDep2PlandTime = request.getParameter("dep2PlandTime");

				System.out.println("depPlandTime : " + depPlandTime);
				
				Map<String,Object> totalMap = new HashMap<String,Object>();
				
				List<Map<String,Object>> airlineList = airService.airplaneSearch(depAirportNm, arrAirportNm, depPlandTime);
				List<Map<String,Object>> parkList = airService.airportParkCheck(depAirportNm);			
				
				totalMap.put("dep", airlineList);
				totalMap.put("parkList", parkList);
				
				if(beforeDep2PlandTime != null && beforeDep2PlandTime != "" && beforeDep2PlandTime.length() > 5){	// 왕복을 선택한 경우
					String dep2PlandTime = beforeDep2PlandTime.replace("/", "");
					List<Map<String,Object>> airlineList2 = airService.airplaneSearch(arrAirportNm, depAirportNm, dep2PlandTime);
					List<Map<String,Object>> parkList2 = airService.airportParkCheck(arrAirportNm);
					
					totalMap.put("dep2", airlineList2);
					totalMap.put("parkList2", parkList2);
				}
	
				
				if(airlineList != null){
					request.setAttribute("airlineInfo", totalMap);
				}else{
					// 조회결과가 없을 경우
				}
					
//				String wIcon = airService.airportWeather(depAirportNm);
				
//				request.setAttribute("wIcon", wIcon);
				
				
				viewPage = "/main/airplaneList.do";
				
			}else if(action.equals("/airPlaneResearch.do")){
				String depPlandTime = request.getParameter("depPlandTime");
				
				JSONArray airlineList = airService.airplaneReSearch(depAirportNm, arrAirportNm, depPlandTime);
				
				
				if(airlineList != null){

				}else{
					// 조회결과가 없을 경우
				}
					
//				String wIcon = airService.airportWeather(depAirportNm);
				
//				request.setAttribute("wIcon", wIcon);
				
				System.out.println("controller totalMap : " + airlineList);
				response.getWriter().print(airlineList);
				response.getWriter().flush();
				response.getWriter().close();
				return;
			}
			
			RequestDispatcher patcher = request.getRequestDispatcher(viewPage);
			patcher.forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
	
	
	
	
	
	