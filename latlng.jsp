<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소와 위도 경도</title>
</head>
<body>

	<c:choose>
		<c:when test="${ pageContext.request.method == 'GET' }">
			<h2>주소를 입력해주세요</h2>
			<hr>
			<form method="POST" action="/sedu/jspexam/latlng.jsp">
				주소 : <input type="text" name="address" placeholder="주소를 입력해주세요">
				<input type="submit" value="검색">
			</form>
		</c:when>
		<c:otherwise>
			<fmt:requestEncoding value="UTF-8" />

			<c:catch var="ex">
				<c:import var="xmldata"
					url="https://maps.googleapis.com/maps/api/geocode/xml">
					<c:param name="address" value="${param.address}" />
					<c:param name="language" value="ko" />
					<c:param name="key" value="AIzaSyD8k2DWC_7yFHCrH6LDR3RfITsmWMEqC8c" />
				</c:import>
				<x:parse xml="${xmldata}" varDom="xdata" />
				<x:if select="$xdata//status = 'OK'">
					<h2>${param.address}의위도와 경도</h2>
					<hr>  		  
	        			주소 : <x:out select="$xdata//formatted_address"
						escapeXml="true" />
					<br>
     					위도 : <x:out select="$xdata//lat" escapeXml="true" />
					<br>
     					경도 : <x:out select="$xdata//lng" escapeXml="true" />
					<br>
				</x:if>
				<c:set var="outFlag" value="true" />
			</c:catch>
			<c:if test="${ empty outFlag }">
				<h2>주소를 전달하세요.</h2>
				<h3>서버로부터 전달된 오류 메시지 : Invalid request. Missing the 'address',
					'components', 'latlng' or 'place_id' parameter.</h3>
			</c:if>
			<x:if select="$xdata//status = 'REQUEST_DENIED'">
				<h2>서비스 사용허가를 받지 못했습니다.</h2>
				<h3>서버로 부터 전달된 오류 메시지 : The provided API key is invalid.</h3>

			</x:if>
			<hr>
			<a href="/sedu/jspexam/latlng.jsp">입력 화면으로</a>
		</c:otherwise>
	</c:choose>
</body>
</html>