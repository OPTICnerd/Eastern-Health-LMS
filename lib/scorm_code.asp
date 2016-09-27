<% ' scorm code
AppPublicKey = "BXZ5GvMJpxZJLLuc3763"
AppKey = request("AppKey")

sResponse = request.querystring


'if AppKey = "BXZ5GvMJpxZJLLuc3763" then
	' code authorized
	ajaxAction = request.querystring("a")
	
	select case ajaxAction
		
		case 1
			statusValue = request.querystring("status")
			courseIDValue = request.querystring("course")
			memberIDValue = request.querystring("mem")
			'call sendEmail(sBody,sSubject,sEmail)
			call saveLessonStatus(memberIDValue, courseIDValue, statusValue)
			
		case 2
			bookmarkValue = request.querystring("bookmark")
			' write this to a database
			' this is fine for testing
			
			'bookmarkArr = Split(bookmarkValue,",",-1,1)
			
					session("courseBookmark") = bookmarkValue
					courseIDValue = request.querystring("course")
					memberIDValue = request.querystring("mem")
					'sEmail = "toddpardy@gmail.com"
			  		'sSubject = "test bookmark email"
			  		'sBody = "bookmark is <br>"&bookmarkArr(1)&""
					call bookmarkTrigger(memberIDValue, courseIDValue, bookmarkValue)
			  		'call sendEmail(sBody,sSubject,sEmail)
	
			
			case 3 ' set course id
				courseValue = request.querystring("course")
				sEmail = "toddpardy@gmail.com"
				sSubject = "test check course name"
				sBody = "The Course  is <br>"&courseValue&""
				'call sendEmail(sBody,sSubject,sEmail)
			case 4 ' course has closed
				memberIDValue = request.querystring("mem")
				sEmail = "toddpardy@gmail.com"
				sSubject = "test check course closed"
				sBody = "The Course has been closed by <br>"&memberIDValue&""
				'call sendEmail(sBody,sSubject,sEmail)
			
			
		case else
		
	end select
'end if

function bookmarkTrigger(MemberID, LMSid, bookmarkValue)

	' delete old bookmarks
	
	sql = "select fldID from tblBookMark where fldLMSid = ? and fldMemberID = ?"
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = Application("DataBaseW")
	cmd.CommandText = sql
	cmd.CommandType = adCmdText
	cmd.Parameters(0) = LMSid
	cmd.Parameters(1) = MemberID
	Set rs = cmd.Execute()
	if (rs.eof or rs.bof) then ' new entry so do insert
		bookmarkID = 0
		
		sql = "insert into tblBookMark (fldLMSid, fldMemberID, fldBookmarkValue, fldIP) VALUES (?,?,?,?)"

		Set cmd = Server.CreateObject("ADODB.Command")
		cmd.ActiveConnection = Application("DataBaseW")
		cmd.CommandText = sql
		cmd.CommandType = adCmdText
		cmd.Parameters(0) = LMSid
		cmd.Parameters(1) = MemberID
		cmd.Parameters(2) = bookmarkValue
		cmd.Parameters(3) = IPaddress
		Set rs = cmd.Execute()
		
	else ' update existing bookmark
		bookmarkID = rs("fldID")
		sql = "update tblBookMark set fldLMSid=?, fldMemberID=?, fldBookmarkValue=?, fldIP = ? where fldID = ?"
		

		Set cmd = Server.CreateObject("ADODB.Command")
		cmd.ActiveConnection = Application("DataBaseW")
		cmd.CommandText = sql
		cmd.CommandType = adCmdText
		cmd.Parameters(0) = LMSid
		cmd.Parameters(1) = MemberID
		cmd.Parameters(2) = bookmarkValue
		cmd.Parameters(3) = IPaddress
		cmd.Parameters(4) = bookmarkID
		Set rs = cmd.Execute()
	
	end if
end function

function getBookMark(LMSid)
	sql = "select fldBookmarkValue from tblBookMark where fldLMSid = ? and fldMemberID = ?"
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = Application("DataBaseW")
	cmd.CommandText = sql
	cmd.CommandType = adCmdText
	cmd.Parameters(0) = LMSid
	cmd.Parameters(1) = session("memberID")
	Set rs = cmd.Execute()
	if (rs.eof or rs.bof) then ' new entry so do insert
		getBookMark = ""
	else
		getBookMark = rs("fldBookmarkValue")
	end if

end function


function saveLessonStatus(memberIDValue, courseIDValue, statusValue)

	' delete old bookmarks
	
	sql = "select fldID, fldCompleteStatus from tblCompletionTracker where fldLMSid = ? and fldMemberID = ?"
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = Application("DataBaseW")
	cmd.CommandText = sql
	cmd.CommandType = adCmdText
	cmd.Parameters(0) = courseIDValue
	cmd.Parameters(1) = memberIDValue
	Set rs = cmd.Execute()
	if (rs.eof or rs.bof) then ' new entry so do insert
		CompleteStatusID = 0
		
		sql = "insert into tblCompletionTracker (fldLMSid, fldMemberID, fldCompleteStatus, fldIP) VALUES (?,?,?,?)"

		Set cmd = Server.CreateObject("ADODB.Command")
		cmd.ActiveConnection = Application("DataBaseW")
		cmd.CommandText = sql
		cmd.CommandType = adCmdText
		cmd.Parameters(0) = courseIDValue
		cmd.Parameters(1) = memberIDValue
		cmd.Parameters(2) = statusValue
		cmd.Parameters(3) = IPaddress
		Set rs = cmd.Execute()
		
	else ' update existing bookmark
		CompleteStatusID = rs("fldID")
		CompleteStatusValue = rs("fldCompleteStatus")
		
		if CompleteStatusValue <> "completed" then ' prevent overwriting completion record in DB
		
		  sql = "update tblCompletionTracker set fldLMSid=?, fldMemberID=?, fldCompleteStatus=?, fldIP = ? where fldID = ?"
		  
  
		  Set cmd = Server.CreateObject("ADODB.Command")
		  cmd.ActiveConnection = Application("DataBaseW")
		  cmd.CommandText = sql
		  cmd.CommandType = adCmdText
		  cmd.Parameters(0) = courseIDValue
		  cmd.Parameters(1) = memberIDValue
		  cmd.Parameters(2) = statusValue
		  cmd.Parameters(3) = IPaddress
		  cmd.Parameters(4) = CompleteStatusID
		  Set rs = cmd.Execute()
		
		end if
	
	end if
	

	

end function

%>


