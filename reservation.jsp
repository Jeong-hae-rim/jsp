<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	System.out.print(name);
	if (name == null) {
		name = "guest";
	}
	String passward = request.getParameter("passwd");
	String sub = request.getParameter("checkbox1");
	String[] sub1 = request.getParameterValues("subject");
	String date = request.getParameter("date");
	LocalDate today = LocalDate.parse(date);
	DateTimeFormatter date1 = DateTimeFormatter.ofPattern(
			"yyyy년 MM월 dd일");
	String date2 = today.format(date1);
	
%>
<%
	if (request.getMethod().equals("POST")) {
		request.setCharacterEncoding("utf-8");
	}
%>
<body>
	<h1><%=request.getParameter("name")%>님의 예약 내용
	</h1>
	<hr>
	<ul>
		<li>선택한 룸 : <%
			if (sub == null)
				out.print("선택한 룸이 없습니다.");
			else {
				out.print(sub);
			}
		%>
		</li>

		<li>추가 요청사항 : <%
			if (sub1 == null)
				out.print("추가 요청 사항이 없습니다.");
			else {
				for (int i = 0; i < sub1.length; ++i) {
					if (i == sub1.length - 1) {
						out.print(sub1[i]);
						break;
					}
					out.print(sub1[i] + ", ");
				}
			}
		%>
		</li>
		<li>예약 날짜 : <%= date2 %>
		</li>
	</ul>
	<hr>
	<a href='http://localhost:8000/sedu/html/reservation.html'>입력화면으로</a>

</body>
</html>