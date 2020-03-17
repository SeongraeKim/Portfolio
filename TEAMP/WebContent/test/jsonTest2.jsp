<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		
		<!-- JQuery CDN 연동 -->
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		
		<script type="text/javascript">
			$(function(){
			    $.ajax({
			        dataType: "json",
			        url: "air_test2.json",
			        mimeType: "application/json",
			        success: function(result){
			        	
			        	JSONParser paser = new JSONParser();
			        	JSONObject obj = (JSONObject) paser.parse(result);
// 			        	JSONObject parse_response = (JSONObject) obj.get("response");
						JSONArray parse_item = (JSONArray) obj.get("item");

			            var tableData = "";
			
			            $.each(parse_item, function(index, item) {
			            	
			            	JSONOnject imsi = (JSONObject) parse_item.get(index);
			            	String airlineNm = (String)imsi.get("airlineNm");
			            	
			                tableData += '<tr>';
			                tableData += '<td>'+item.airlineNm+'</td>';
			                tableData += '<td>'+item.arrAirportNm+'</td>';
			                tableData += '<td>'+item.arrPlandTime+'</td>';
			                tableData += '<td>'+item.depAirportNm+'</td>';
			                tableData += '<td>'+item.depPlandTime+'</td>';
			                tableData += '<td>'+item.economyCharge+'</td>';
			                tableData += '<td>'+item.vihicleId+'</td>';
			                tableData += '</tr>';
			            });
			
			            $("#example").append(tableData);
			        }
			    });
			});
		</script>
		
	</head>
	<body>
		<h2>Info</h2>
		<table id="example" border="2" width="500" height="70" cellpadding="5">
			<tr align="center">
		        <th>No</th>
		        <th>Name</th>
		        <th>Age</th>
			</tr>
		</table>
	</body>
</html>