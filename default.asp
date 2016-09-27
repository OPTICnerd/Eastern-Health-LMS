<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	set cnnR = Server.CreateObject("ADODB.Connection")
	cnnR.Open Application("DataBase")
	PageName = "My Program"
	PageType = "portal"
%>

<!--#include file="lib/master.asp" -->
<!--#include file="lib/design.asp" -->

<%  
	call siteHeader(PageType)
	
	if isLoggedIn = True then
		call showMyAccount(session("MemberID"))
	else
		' show login box
		call showLogin
	end if
%>


<% call siteFooter(PageType) %>

