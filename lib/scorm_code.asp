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
			bookmarkValue = Base64Decode(request.querystring("bookmark"))
			'w(bookmarkValue)
			'w(bookmarkValue&"#-#_$")
			' write this to a database
			' this is fine for testing
			
			'bookmarkArr = Split(bookmarkValue,",",-1,1)
			
			session("courseBookmark") = bookmarkValue
			w(session("courseBookmark"))
			courseIDValue = request.querystring("course")
			memberIDValue = request.querystring("mem")
			sEmail = "toddpardy@gmail.com"
			sSubject = "test bookmark email"
			sBody = "bookmark is <br>"&bookmarkValue&""
			'w(memberIDValue)
			'w(courseIDValue)
			'w(bookmarkValue)
			'w(decode(bookmarkValue))
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


Function Base64Decode(base64String)
'w(base64String)
  'rfc1521
  '1999 Antonin Foller, Motobit Software, http://Motobit.cz
  Const Base64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  Dim dataLength, sOut, groupBegin
  
  'remove white spaces, If any
  base64String = Replace(base64String, vbCrLf, "")
  base64String = Replace(base64String, vbTab, "")
  base64String = Replace(base64String, " ", "")
  
  'The source must consists from groups with Len of 4 chars
  dataLength = Len(base64String)
  If dataLength Mod 4 <> 0 Then
    Err.Raise 1, "Base64Decode", "Bad Base64 string."
    Exit Function
  End If

  
  ' Now decode each group:
  For groupBegin = 1 To dataLength Step 4
    Dim numDataBytes, CharCounter, thisChar, thisData, nGroup, pOut
    ' Each data group encodes up To 3 actual bytes.
    numDataBytes = 3
    nGroup = 0

    For CharCounter = 0 To 3
      ' Convert each character into 6 bits of data, And add it To
      ' an integer For temporary storage.  If a character is a '=', there
      ' is one fewer data byte.  (There can only be a maximum of 2 '=' In
      ' the whole string.)

      thisChar = Mid(base64String, groupBegin + CharCounter, 1)

      If thisChar = "=" Then
        numDataBytes = numDataBytes - 1
        thisData = 0
      Else
        thisData = InStr(1, Base64, thisChar, vbBinaryCompare) - 1
      End If
      If thisData = -1 Then
        Err.Raise 2, "Base64Decode", "Bad character In Base64 string."
        Exit Function
      End If

      nGroup = 64 * nGroup + thisData
    Next
    
    'Hex splits the long To 6 groups with 4 bits
    nGroup = Hex(nGroup)
    
    'Add leading zeros
    nGroup = String(6 - Len(nGroup), "0") & nGroup
    
    'Convert the 3 byte hex integer (6 chars) To 3 characters
    pOut = Chr(CByte("&H" & Mid(nGroup, 1, 2))) + _
      Chr(CByte("&H" & Mid(nGroup, 3, 2))) + _
      Chr(CByte("&H" & Mid(nGroup, 5, 2)))
    
    'add numDataBytes characters To out string
    sOut = sOut & Left(pOut, numDataBytes)
  Next

  Base64Decode = sOut
End Function
%>


