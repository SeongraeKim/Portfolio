package com.ode.LongPollingChat;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.AsyncContext;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/shoutServlet"}, asyncSupported=true)
public class ShoutServlet extends HttpServlet {
    private List<AsyncContext> contexts = new LinkedList<>();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        final AsyncContext asyncContext = request.startAsync(request, response);
        response.setContentType("text/html; charset=utf-8");
        asyncContext.setTimeout(10 * 60 * 1000);
        contexts.add(asyncContext);
        System.out.println("Here is Get");
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	System.out.println("1");
    	request.setCharacterEncoding("UTF-8");
    	response.setContentType("text/html; charset=utf-8");
        List<AsyncContext> asyncContexts = new ArrayList<>(this.contexts);
    	System.out.println("2");
    	this.contexts.clear();
        String name = request.getParameter("name");
        String message= request.getParameter("message");
        
 /*       pollingDAO pollingdao=new pollingDAO();
        pollingdao.submit(name, message);*/
    	System.out.println("3");
        String htmlMessage = "<p><b>" + name + "</b><br/>" + message + "</p>";
        ServletContext sc = request.getServletContext();
        if (sc.getAttribute("message") == null) {
        	System.out.println(htmlMessage);
            sc.setAttribute("message", htmlMessage);
        } else {
            String currentMessages = (String) sc.getAttribute("message");
            System.out.println(currentMessages);
            sc.setAttribute("message", htmlMessage + currentMessages);
        }
        for (AsyncContext asyncContext : asyncContexts) {
            try (PrintWriter writer = asyncContext.getResponse().getWriter()) {
                writer.println(htmlMessage);
                writer.flush();
                asyncContext.complete();
            } catch (Exception ex) {
            	ex.printStackTrace();
            }
        }
       return;
       //response.sendRedirect("/LongChatView/LongChat.jsp");

    }
    
    
    
    
    
    
    
    
}