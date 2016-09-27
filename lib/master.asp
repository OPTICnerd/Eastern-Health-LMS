<%

dim referPage
dim SiteTitle, SubSiteTitle
dim SiteAddress
dim IPaddress
dim isLoggedIn 
dim varUserMessage
dim urlSubstring
dim Action
dim CourseID
dim pageName
dim copyYear
dim adminEmail
dim errEmail
dim LMSid
dim EditID
dim AppPublicKey
dim AppKey

if Request.ServerVariables("HTTPS") = "off" then
	method = Request.ServerVariables("REQUEST_METHOD")
	srvname = Request.ServerVariables("SERVER_NAME")
	scrname = Request.ServerVariables("SCRIPT_NAME")
	sRedirect = "https://" & srvname & scrname
	sQString = Request.Querystring
	if Len(sQString) > 0 Then
		sRedirect = sRedirect & "?" & sQString
	end if	
	Response.Redirect sRedirect
end if
   
   

response.Charset="utf-8"
SiteTitle = "Eastern Health"
SubSiteTitle = "Learning Management Platform"
SiteAddress = "https://easternhealth.mycpd.ca/"
AppPublicKey = "BXZ5GvMJpxZJLLuc3763"
AppKey = request("AppKey")

if Request.ServerVariables("QUERY_STRING") = "" then
	referPage = request.ServerVariables("SCRIPT_NAME")
else
	referPage = request.ServerVariables("SCRIPT_NAME")&"?"&Request.ServerVariables("QUERY_STRING")
end if


doLoginCheck

Const adCmdText = 1                  'Evaluate as a textual definition
Const adCmdStoredProc = 4


IPaddress = Request.ServerVariables("remote_addr")

copyYearArr = Split(Now,"/",-1,1)
copyYear = left(copyYearArr(2), 4)

If request.form("frmEditID") <> "" then
	If isNumeric(request.form("frmEditID")) Then
		EditID = IllegalChars(Trim(request.form("frmEditID")))
	else
		EditID = 0
	end if
else
	EditID = 0
end if


If request.form("frmAction") <> "" then
	If isNumeric(request.form("frmAction")) Then
		Action = IllegalChars(Trim(request.form("frmAction")))
		call doAction(Action)
	else
		Action = 0
	end if
else
	Action = 0
end if

If request.form("frmLMSid") <> "" then
	LMSid = IllegalChars(Trim(request.form("frmLMSid")))
end if

if LMSid = "" and Split(request.ServerVariables("SCRIPT_NAME"),"/")(1)="lms" then
	urlArray = Split(request.ServerVariables("SCRIPT_NAME"),"/")
	'echo(ubound(urlArray))
	if ubound(urlArray) > 3 then
		LMSid = Split(request.ServerVariables("SCRIPT_NAME"),"/")(3)
	end if
end if

if LMSid <> "" then
	isCourse = True
end if	

function doAction(Action)
	select case Action	
		case 1 ' process login attempt
			varEmail = IllegalChars(request.form("frmEmail"))
			varPassword = IllegalChars(request.form("frmPassword"))
	
			call processLogin(varEmail, varPassword)
		case 2 ' logout admin user
			Session.Abandon
			Response.Cookies("account")("email")=""
			Response.Cookies("account")("password")=""
			'response.Redirect(referPage)
			'regMessage =  showMessage(1, Request.ServerVariables("SCRIPT_NAME"))
			'echo(Request.ServerVariables("SCRIPT_NAME"))
			response.Redirect("/")
		case 3 
		
			'varEmail = IllegalChars(request.form("frmEmail"))
			'call account(varEmail, lang)
		case else
	end select
end function

function doLoginCheck
	isLoggedIn = False
	  if session("MemberActive") = True  then
		  isLoggedIn = True
	  else
		  ' session is empty so now check the cookies
		  cookieEmail=Request.Cookies("account")("email")
		  cookieKey=Request.Cookies("account")("key")
		  if cookieEmail <> "" then
		  	Set rs = server.CreateObject ("Adodb.Recordset")
			sql = "select fldID, fldEmail, fldName, fldFirstName from tblCMEMember where fldEmail ='"&cookieEmail&"'"
			set rs=cnnR.execute(sql)
				If (rs.eof or rs.bof) then
					session("MemberID") = ""
					session("AdminActive") = ""
					session("AdminID") = ""
					isLoggedIn = False
				else
					if cookieKey = rs("fldID") then
						isLoggedIn = True
							session("MemberActive") = True
							session("MemberID") = rs("fldID")
							session("MemberName") = rs("fldFirstName")&" "&rs("fldLastName")
							session("cmi.core.student_id") = rs("fldID")
							session("cmi.core.student_name") = rs("fldLastName")&", "&rs("fldFirstName")
							session("MemberEmail") = rs("fldEmail")
							isLoggedIn = True
					else
						session("MemberID") = ""
						session("MemberActive") = ""
						session("MemberName") = ""
						session("MemberEmail") = ""
					end if
				end if
			else
			'session("AdminActive") = ""
			isLoggedIn = False
			end if
	end if
end function

function processLogin(email, password)
	if email = "" then
		session("UserMessage") =  showMessage(1, "you did not provide a email address.")
	else
		processLogin = True
	end if

	if password = "" then
		session("UserMessage") =  showMessage(1, "you did not provide your password.")
	else
		processLogin = True
	end if
	
	if processLogin = True then
	  Set rs = server.CreateObject ("Adodb.Recordset")
	  session("UserMessage") = ""
	  sql = "select fldID, fldEmail, fldPassword, fldFirstName, fldLastName, fldRole, fldCohortID, fldAccountKey from tblMembers where fldEmail =? and fldStatus = ?"
  
	  Dim cmd
	  Set cmd = Server.CreateObject("ADODB.Command")    
	  cmd.ActiveConnection = cnnR
	  cmd.CommandText = sql
	  cmd.CommandType = adCmdText
	  cmd.Parameters(0) = email
	  cmd.Parameters(1) = 1
	  Set rs = cmd.Execute()
  
	  If (rs.eof or rs.bof) then
		session("UserMessage") =  showMessage(1, "We are sorry but your login attempt failed.")
		session("MemberID") = ""
	  else
		  if password = rs("fldPassword") then
			  session("UserMessage") = showMessage(3, "You are now logged in.")
			  session("MemberActive") = True
			  session("MemberID") = rs("fldID")
			  session("MemberName") = rs("fldFirstName")&" "&rs("fldLastName")
			  session("MemberEmail") = rs("fldEmail")
			  session("AccountType") = rs("fldRole")
			  session("CohortID") = rs("fldCohortID")
			  session("AccountKey") = rs("fldAccountKey")
			  
			  ' form scorm courses
			  session("cmi.core.student_id") = rs("fldID")
			  session("cmi.core.student_name") = rs("fldLastName")&", "&rs("fldFirstName")
				  
			  response.Redirect("/")
		  else
			  	  session("UserMessage") =  showMessage(1, "Login attempt failed. Your password was incorrect.")
			  session("MemberID") = ""
		  end if
	  end if
	end if
end function


function charFix(text)
	charFix = trim(text)
	
	If Not charFix = "" Then
		charFix = Replace(charFix, "é", "&eacute;")
		charFix = Replace(charFix, "É", "&Eacute;")
		charFix = Replace(charFix, "°", "&deg;")
		charFix = Replace(charFix, "ç", "&ccedil;")
		charFix = Replace(charFix, "ê", "&ecirc;")
		charFix = Replace(charFix, "Ê", "&Ecirc;")
		charFix = Replace(charFix, "œ", "&#339;")
		charFix = Replace(charFix, "î", "&icirc;")
		charFix = Replace(charFix, "ô", "&ocirc;")
		charFix = Replace(charFix, "è", "&egrave;")
		charFix = Replace(charFix, "à", "&agrave;")
		charFix = Replace(charFix, "'", "&#8217;")
		'charFix = Replace(charFix,vbCrLf,"<br />")
	else
		charFix = charFix
	end if
end function

'Function IllegalChars to guard against SQL injection
Function IllegalChars(sInput)

  'Declare variables
  Dim sBadChars, iCounter
  'Set IllegalChars to False
  IllegalChars=False
  'Create an array of illegal characters and words
  sBadChars=array("xp_", "sysobject")
  'Loop through array sBadChars using our counter & UBound function
  For iCounter = 0 to uBound(sBadChars)
  'Use Function Instr to check presence of illegal character in our variable
  	If Instr(sInput,sBadChars(iCounter))>0 Then
  		IllegalChars=True
  		echo("Bad Request")
 	 	Response.end()
	else
		IllegalChars = killChars(sInput)
  	End If
  Next
End function

Function GetSecureVal(param)
	If IsEmpty(param) Or param = "" Then
		param = -1
		GetSecureVal = param
		Exit Function
	End If
	
	If IsNumeric(param) Then
		GetSecureVal = param
	Else
		GetSecureVal = Replace(CStr(param), "'", "&#8217;")
		GetSecureVal = killChars(GetSecureVal)
	
	End If

End Function

function killChars(strWords)     
	dim badChars     
	dim newChars     
    
	badChars = array("@@", "--", "xp_", "<script>", "</script>")     
	
	newChars = strWords     
    
	for i = 0 to uBound(badChars)     
		newChars = replace(newChars, badChars(i), "")     
	next     
    
	killChars = newChars     
    
end function

Function TextPreview(strText, nChars)
	Dim nPos
    	' Uncomment next line to replace line breaks with spaces
	' strText = Replace(strText, vbCrLf, " ")

	' Check if it's longer than limit
    	If Len(strText) > nChars And nChars > 4 Then
        	' Find the end of last whole word that we can use
        	nPos = InStrRev(Left(strText, nChars - 3), " ")

        	If nPos > 0 Then
			' Take whole words only 
            		TextPreview = Left(strText, nPos) & "..."
        	Else
			' No spaces were found - take what we can
            		TextPreview = Left(strText, nChars - 4) & " ..."
	        End If
    	Else
		' Take nChars from the text
        	TextPreview = Left(strText, nChars)
    	End If
End Function

Function genString(strLen)
'Declare variables
Dim sDefaultChars
Dim iCounter
Dim theString
Dim iPickedChar
Dim iDefaultCharactersLength

'Initialize variables
sDefaultChars="abcdefghijklmnopqrstuvxyzABCDEFGHIJKLMNOPQRSTUVXYZ0123456789"

iDefaultCharactersLength = Len(sDefaultChars)
Randomize'initialize the random number generator
'Loop for the number of characters password is to have
For iCounter = 1 To strLen
'Next pick a number from 1 to length of character set
iPickedChar = Int((iDefaultCharactersLength * Rnd) + 1)
'Next pick a character from the character set using the random number iPickedChar
'and Mid function
theString = theString & Mid(sDefaultChars,iPickedChar,1)
Next
genString = theString
End Function


function echo(input)
	echo = input
	if IsNull(echo) then
		Response.Write("error")
	else
		Response.Write(echo) & Chr(13) & Chr(10)
	end if
end function

function w(sInput)
	echo(sInput&"<br>")
end function

function getFormData(formInput, InputType)
	select case InputType
		case "text"
			getFormData = IllegalChars(Trim(request.form(formInput)))
		case "int"
			getFormData = IllegalChars(Trim(request.form(formInput)))
			If isNumeric(getFormData) Then
				getFormData = getFormData
			else
				getFormData = 0
			end if
		case else
		
	end select

end function


function optionchecker(val1, val2)
	if val1 = val2 then
		optionchecker = "selected=""selected"""
	else
		'optionchecker = val1&" "&val2
		'optionchecker = val1 &""&val2
	end if
end function

function optioncheckerRadio(val1, val2)
	if cint(val1) = cint(val2) then
		optioncheckerRadio = "checked=""checked"""
	else
		'optionchecker = val1&" "&val2
		'optioncheckerRadio = val1 &""&val2
	end if
end function


function optioncheckerInt(val1, val2)
	if cint(val1) = cint(val2) then
		optioncheckerInt = "selected=""selected"""
	else
		'optioncheckerInt = val1 &""&val2
	end if
end function

function isInArray(valInput, dbValue)
	isInArray = False
	if dbValue = "" then
	
	else
		dbValArray = Split(dbValue,",",-1,1)
		for a = lbound(dbValArray) to ubound(dbValArray)
			if cint(valInput) = cint(dbValArray(a)) then
				isInArray = True
				Exit For
			else
				isInArray = False
			end if
		Next

			
	end if
	
end function


function showMessage(msgType, msgText)
	select case msgType
		case 1 ' error
			msgClass = "danger"
		case 2 ' warning
			msgClass = "warning"
		case 3 ' success
			msgClass = "success"
		case 4 ' info
			msgClass = "info"
		case 5 ' info
			msgClass = "royal"
		case 6 ' info
			msgClass = "info"				
		case else ' info
			msgClass = "primary"
	end select
	showMessage = "<div class=""alert alert-"&msgClass&" animated fadeOut animation-delay-14"">"
	showMessage = showMessage + "<button type=""button"" class=""close"" data-dismiss=""alert"" aria-hidden=""true"">&times;</button>"
    showMessage = showMessage + "  <p>"&msgText&"</p>"
    showMessage = showMessage + "</div><!-- notification "&msgClass&" -->"

end function

function loginRequired 
	if isLoggedIn = False then
		response.Redirect("/")
	else
		'
	end if 
end function

function doAdminCheck
	isAdminLoggedIn = False
	  if session("AdminActive") = True  then
		  isAdminLoggedIn = True
	  else
		  isAdminLoggedIn = False
	  end if
end function

Function Decode(sIn)
    dim x, y, abfrom, abto
    Decode="": ABFrom = ""

    For x = 0 To 25: ABFrom = ABFrom & Chr(65 + x): Next 
    For x = 0 To 25: ABFrom = ABFrom & Chr(97 + x): Next 
    For x = 0 To 9: ABFrom = ABFrom & CStr(x): Next 

    abto = Mid(abfrom, 14, Len(abfrom) - 13) & Left(abfrom, 13)
    For x=1 to Len(sin): y=InStr(abto, Mid(sin, x, 1))
        If y = 0 then
            Decode = Decode & Mid(sin, x, 1)
        Else
            Decode = Decode & Mid(abfrom, y, 1)
        End If
    Next
End Function

' USE: location.href="nextpage.asp?" & encode("sParm=" & sData)

Function Encode(sIn)
    dim x, y, abfrom, abto
    Encode="": ABFrom = ""

    For x = 0 To 25: ABFrom = ABFrom & Chr(65 + x): Next 
    For x = 0 To 25: ABFrom = ABFrom & Chr(97 + x): Next 
    For x = 0 To 9: ABFrom = ABFrom & CStr(x): Next 

    abto = Mid(abfrom, 14, Len(abfrom) - 13) & Left(abfrom, 13)
    For x=1 to Len(sin): y = InStr(abfrom, Mid(sin, x, 1))
        If y = 0 Then
             Encode = Encode & Mid(sin, x, 1)
        Else
             Encode = Encode & Mid(abto, y, 1)
        End If
    Next
End Function

function sendEmail(sBody,sSubject,sEmail)
	mailHost = "localhost"
	Set Mail = Server.CreateObject("Persits.MailSender")
   ' enter valid SMTP host
   Mail.Host = mailHost
   Mail.From = "no-reply@mdcme.ca"
   Mail.FromName = ""
   Mail.AddAddress sEmail
   ' message subject
   Mail.Subject = sSubject
   ' message body
   Mail.Body = sBody
   Mail.IsHTML = True
   Mail.Send	' send message
End function

function formField(fieldType, label, fieldID, fieldName, DBvalue)
	select case fieldType
		case "text", "password"
			echo("<div class=""form-group"">")
			echo("	<label for="""&fieldName&""">"&label&"</label>") 
			echo("	<input id="""&fieldID&""" name="""&fieldName&""" type="""&fieldType&""" value="""&DBvalue&""" class=""form-control"" />")
			echo("</div>")
		case "date"
			echo("<div class=""form-group input-append date"">")
			echo("	<label for="""&fieldName&""">"&label&"</label>") 
			echo("<div class='input-group date' id='datetimepicker1'>")
			echo("	<input id="""&fieldID&""" data-link-format=""yyyy-mm-dd"" data-date-format=""dd MM yyyy"" name="""&fieldName&""" type=""text"" value="""&DBvalue&""" class=""form-control form_date"" /><span class=""input-group-addon""><span class=""glyphicon glyphicon-calendar""></span></span>")
			echo("</div>")
			echo("</div>")
		case "hidden"
			echo("	<input id="""&fieldID&""" name="""&fieldName&""" type="""&fieldType&""" value="""&DBvalue&""" />")
		case "textarea"
			echo("<div class=""form-group"">")
			echo("<label for="""&fieldName&""" class=""control-label"">"&label&"</label>")
			echo("<textarea class=""contentEditor"" id="""&fieldID&""" name="""&fieldName&""">"&DBvalue&"</textarea>")
			echo("</div>")
	
		case else
		
	end select
end function


function showMyAccount(MemberID)
%>


<div class="container">
    <div class="row">
        
        <div class="col-md-8">
            <section class="css-section">
                  <% call getMyCourse(session("MemberID"), session("CohortID")) %>
            </section>
        </div>
        <div class="col-md-4">
            <div class="content-box box-default">
				<span class="icon-ar icon-ar-lg icon-ar-inverse icon-ar-circle"><i class="fa fa-gears"></i></span>
					<h4 class="content-box-title">Account Information</h4>
					<p>Name: <%=session("MemberName")%><br>Email Address: <%=session("MemberEmail")%></p>
			</div>
            <br>
            <div class="progress progress-striped active">
            	<div class="progress-bar" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width: 70%;">
            		<span class="sr-only">70% Complete</span>
            	</div>
            </div>
        </div>
    </div>
</div>

<%
end function


function getMyCourse(memberID, CohortID)
	sql="SELECT A.fldCourseName, A.fldCourseTypeID, B.fldCourseTypeName, A.fldLMSid, C.fldCohortID, C.fldStartDate, A.fldStatus, D.fldStatusName FROM tblCourses AS A INNER JOIN tblCourseType AS B ON A.fldCourseTypeID = B.fldID INNER JOIN tblCourseTimers AS C ON A.fldID = C.fldCourseID INNER JOIN tblStatus AS D ON A.fldStatus = D.fldID ORDER BY C.fldStartDate ASC"

		Set cmd1 = Server.CreateObject("ADODB.Command")    
			cmd1.ActiveConnection = cnnR
			cmd1.CommandText = sql
			cmd1.CommandType = adCmdText
			'cmd1.Parameters(0) = CohortID
		Set rs1 = cmd1.Execute()

		If (rs1.eof or rs1.bof) then
		' nothing to display
		else
			rsArr1 = rs1.GetRows()
			echo("<table class=""table"">")
			echo("<thead>")
			echo("  <tr>")
			echo("	<th>Course Name</th>")
			echo("	<th>Course Type</th>")
			echo("	<th>Complete</th>")
			echo("  </tr>")
			echo("</thead>")
			echo("<tbody>")
			For b = LBound(rsArr1, 2) To UBound(rsArr1, 2)
				varCourseName = rsArr1(0,b)
				varCourseTypeID = rsArr1(1,b)
				varCourseTypeText = rsArr1(2,b)
				varLMSid = rsArr1(3,b)
				echo("<tr>")
				if varCourseTypeID = 1 then ' online course
					echo("<td><a onclick='launchCourse("&varLMSid&");'>"&varCourseName&"</a></td>")
					echo("<td><a class=""courseLaunch"" lmsID="""&varLMSid&""">"&varCourseName&"</a></td>")
				else ' onsite course
					echo("<td>"&varCourseName&"</td>")
				end if
				
				echo("<td>"&varCourseTypeText&"</td>")
				echo("<td><br></td>")
				echo("</tr>")
			Next
			echo("	</tbody>")
			echo("</table>")
	end if
end function


function showStatus(StatusID)
Set rs = server.CreateObject ("Adodb.Recordset")
	
	sql = "select fldStatusName from tblStatus where fldID =?"
	
	Set cmd = Server.CreateObject("ADODB.Command")    
		cmd.ActiveConnection = cnnR
		cmd.CommandText = sql
		cmd.CommandType = adCmdText
		cmd.Parameters(0) = StatusID
	
		Set rs = cmd.Execute()
			If (rs.eof or rs.bof) then
				showStatus = "Error loading status"
			else
				showStatus = rs("fldStatusName")
			end if
end function
%>

  
       