<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1">
		<tr>
			<td colspan="4">국제시장환율</td>
		</tr>
<%
	
	
	URL url = new URL("https://finance.naver.com/");
	BufferedReader reader = new BufferedReader(new InputStreamReader(url.openStream(), "euc-kr"));
	String line; int check_line = 0;
	while((line = reader.readLine()) != null){
		
		if(line.contains("<a href=\"/marketindex/worldExchangeDetail.nhn?marketindexCd"))
			check_line = 1;
		if(line.contains("<a href=\"/marketindex/?tabSel=worldExchange#tab_section\""))
			check_line = 0;
		
		if(check_line == 1){
			if(line.contains("<a href=\"/marketindex/worldExchangeDetail.nhn?marketindexCd=")){
				
				String temp = line.split(">")[2].split("<")[0];
				temp = temp.trim();
%>
				<tr>
					<td><%=temp %></td>
<%
				System.out.println(temp);
			}
			 if(line.contains("<td>") && !line.contains("em")){
				
				String temp = line.split(">")[1].split("<")[0];
%>
					<td><%=temp %></td>
<%
				System.out.println(temp);
			}
			 if(line.contains("<td>") && line.contains("em")){
				
				String temp = line.split(">")[3].split("<")[0];
				System.out.print(temp);
%>
					<td><%=temp %></td>
<%
				String temp2 = line.split(">")[5].split("<")[0];
%>
					<td><%=temp %></td>
<%
				System.out.println(temp2);
				System.out.println();
			}
		}
	}
	reader.close();
%>
		</tr>
	</table>

</body>
</html>