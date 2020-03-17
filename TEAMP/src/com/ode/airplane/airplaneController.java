package com.ode.airplane;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sun.rmi.server.Dispatcher;

// JSON뷰어	-	http://jsonviewer.stack.hu/

// airplaneSearch.do	->		airplaneList.jsp 
//@WebServlet("/airplane/*")
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
		
		try {
			
			if(action.equals("/airplaneSearch.do")){
				
				String depAirportNm = request.getParameter("depAirportNm");
				String arrAirportNm = request.getParameter("arrAirportNm");
				String depPlandTime = request.getParameter("depPlandTime");
				
				List<Map<String,Object>> airlineList = airService.airplaneSearch(depAirportNm, arrAirportNm, depPlandTime);
				List<Map<String,Object>> parkList = airService.airportParkCheck(depAirportNm);
				String wIcon = airService.airportWeather(depAirportNm);
				
				
				if(airlineList != null){
					request.setAttribute("airlineList", airlineList);
				}
//				else{
//					request.setAttribute("airlineList", null);
//				}
				
				request.setAttribute("parkList", parkList);
				request.setAttribute("wIcon", wIcon);
				
				viewPage = "/airplaneList.jsp";
				
			}
			
			RequestDispatcher patcher = request.getRequestDispatcher(viewPage);
			patcher.forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
}








