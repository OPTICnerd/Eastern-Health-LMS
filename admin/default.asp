<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	set cnnR = Server.CreateObject("ADODB.Connection")
	cnnR.Open Application("DataBase")
	PageName = "Portal Administration"
	PageType = "admin"
%>

<!--#include file="../lib/master.asp" -->
<!--#include file="../lib/admin_code.asp" -->
<!--#include file="../lib/design.asp" -->

<%  
	call siteHeader(PageType)
	
	call adminFunction(aid)
	
	call siteFooter(PageType)
	 
%>

