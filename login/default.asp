<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	set cnnR = Server.CreateObject("ADODB.Connection")
	cnnR.Open Application("DataBase")
	PageName = "Login"
	PageType = "login"
%>

<!--#include file="../lib/master.asp" -->
<!--#include file="../lib/design.asp" -->

<%  
	call siteHeader(PageType)
	call siteFooter(PageType) 
	
%>
<script>
$(document).ready(wrapResize);
$(window).resize(wrapResize);

function wrapResize (){
    var back = $('.paper-back-full');

    var size = $(window).height();
    back.css('min-height', size + "px");
}
</script>
