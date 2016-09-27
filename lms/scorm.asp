<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	set cnnR = Server.CreateObject("ADODB.Connection")
	cnnR.Open Application("DataBase")
	PageName = "SCORM API"
	PageType = "api"
%>

<!--#include file="../lib/master.asp" -->
<!--#include file="../lib/scorm_code.asp" -->

<%
cnnR.Close
set cnnR = Nothing
%>
