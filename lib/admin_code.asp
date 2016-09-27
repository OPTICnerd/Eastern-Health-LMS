<% ' admin code
dim aID
dim Step
dim adminAction

If Request.QueryString("aid") <> "" then
	aID = Trim(Request.QueryString("aid"))
	If isNumeric(aID) then
		aID = aID
	else
		aID = 0
	end if
else
	aID = 0
end if

If request.form("frmStep") <> "" then
	If isNumeric(request.form("frmStep")) Then
		Step= IllegalChars(Trim(request.form("frmStep")))
	else
		Step = 0
	end if
else
	Step = 0
end if

If request.form("frmAdminAction") <> "" then
	If isNumeric(request.form("frmAdminAction")) Then
		adminAction = IllegalChars(Trim(request.form("frmAdminAction")))
		call doAdminAction(adminAction)
	else
		adminAction = 0
	end if
else
	adminAction = 0
end if

function adminFunction(aid)

echo("<section class=""margin-top margin-bottom"">")
echo("    <div class=""container"">")
echo("        <div class=""row"">")
w(aid)
	select case aid
		case 1 ' manage users
			call manageUsers
		case 2 ' manage courses
			call manageCourses
		case 3 ' manage cohorts
			call cohortAdmin(Step)
		case 4 ' manage portal resources
			call manageResources
	end select 


echo("		</div>")
echo("	</div>")
echo("</section>")
end function

function doAdminAction(adminAction)
	select case adminAction	
		case 1 ' add / update cohort info
			call addUpdateCohort(EditID)
	
			
		case 2 ' 
	
			
		case 3 ' 
	
			
		case 4 ' 
	
		case 5 ' add / update Course Information
			
		
		case 6 ' add first page to course menu
		
		case 7 ' add / edit page to course
			
		
		case 8 ' update menu order
			
		
		case 9 ' add update member account
			call addUpdateMemberAccount(EditID)
						
		
		case 11 
	
	
	
		case else
	
	end select


end function

function addUpdateCohort(EditID)
	varCohortName = GetSecureVal(request.form("frmCohortTitle"))
	varStatus = GetSecureVal(request.form("frmStatus"))
	
	if EditID > 0 then
		sql ="update tblCohorts set fldCohortName=?,fldStatus=? where fldID=?"		
	else
		sql ="insert into tblCohorts (fldCohortName,fldStatus) Values (?,?)"
	end if
	
	Set cmd = Server.CreateObject("ADODB.Command")    
		cmd.ActiveConnection = Application("DataBaseW")
		cmd.CommandText = sql
		cmd.CommandType = adCmdText
		cmd.Parameters(0) = varCohortName
		cmd.Parameters(1) = varStatus
		
		if EditID > 0 then
			cmd.Parameters(2) = EditID
		end if
	
		Set rs = cmd.Execute()
			
		sql = ""
		Step = 0 
end function



function manageUsers
	echo("manageUsers")
end function

function manageCourses
	echo("manageCourses")
end function

function cohortAdmin(Step)
	echo(varAdminMessage)
	
	select case step
	
		case 0
	
			echo("<form method=""post"" role=""form"">")
			echo("	<input type=""hidden"" name=""frmStep"" value=""1"">")
			echo("	<input type=""hidden"" name=""frmEditID"" value=""0"">")
			echo("	<input type=""submit"" value=""Add New Cohort"" class=""btn btn-primary btn-s"">")
			echo("</form><br>")
					
			sql = 	"Select * from tblCohorts" 
					
			Set cmd = Server.CreateObject("ADODB.Command")    
				cmd.ActiveConnection = cnnR
				cmd.CommandText = sql
				cmd.CommandType = adCmdText
			
			Set rs = cmd.Execute()
				if (rs.eof or rs.bof) then
					'

				else
					rsArr = rs.GetRows()
					echo("<table class=""table table-bordered table-striped"">")
					echo("	<thead>")
					echo("<tr>")
					echo("	<th>ID</th>")
					echo("	<th>Cohort Title</th>")
	
					echo("	<th>Status</th>")
					echo("	<th>Action</th>")
					echo("</tr>")
					echo("		</thead>")
					echo("		<tbody>")
					For a = LBound(rsArr, 2) To UBound(rsArr, 2)
						varCohortID = rsArr(0,a)
						varCohortTitle = rsArr(1,a)
				
						varCohortStatus = rsArr(2,a)
						
						echo("<tr>")
						echo("	<td>"&varCohortID&"</td>")
						echo("	<td>"&varCohortTitle&"</td>")
			
						echo("	<td>"&showStatus(varCohortStatus)&"</td>")
						echo("	<td>")
						echo("		<form method=""post"" role=""form"">")
						echo("			<input type=""hidden"" name=""frmStep"" value=""1"">")
						echo("			<input type=""hidden"" name=""frmEditID"" value="""&varCohortID&""">")
						echo("			<input type=""submit"" value=""Edit"" class=""btn btn-primary btn-xs"">")
						echo("		</form>")
						
						echo("	</td>")
					
						echo("</tr>")
					Next
					echo("		</tbody>")
					echo("</table>")
				end if
	case 1
		if EditID > 0 then
		  sql = "select * from tblCohorts where fldID = ?"
		  Set cmd = Server.CreateObject("ADODB.Command")    
			  cmd.ActiveConnection = cnnR
			  cmd.CommandText = sql
			  cmd.CommandType = adCmdText
			  cmd.Parameters(0) = EditID
		  
		  Set rs = cmd.Execute()
			  if (rs.eof or rs.bof) then
				varCohortTitle = ""
				varCohortStatus = ""
			  else
				varCohortTitle = rs("fldCohortName")
				varCohortStatus = rs("fldStatus")
			  end if
		  
		  end if
			
			echo("<div class=""col-md-6"">")
			echo("<h4>Cohort Details</h4>")
			echo("	<form method=""post"" role=""form"">")
			echo("		<div class=""form-group"">")
			echo("      		<label for=""Cohort Title"">Cohort Title</label>")
			echo("			<input type=""text"" class=""form-control"" name=""frmCohortTitle"" id=""frmCohortTitle"" value="""&varCohortTitle&""">") 
			echo("      	</div>")
			
			
			

			echo("		<div class=""form-group"">")
			echo("      		<label for=""Cohort Status"">Cohort Status</label><br>")
			call selectStatus(varCohortStatus)
			echo("		</div>")
			echo("		<input type=""hidden"" name=""frmStep"" value=""2"">")
			echo("		<input type=""hidden"" name=""frmEditID"" value="""&EditID&""">")
			echo("		<input type=""hidden"" name=""frmAdminAction"" value=""1"">")
			echo("		<button type=""submit"" class=""btn btn-ar btn-primary"">Save</button>")					
			echo("	</form>")
			echo("<br>")
		echo("</div>")
		echo("<div class=""col-md-2"">")
		
		echo("</div>")
		echo("<div class=""col-md-4"">")
			call showMembersInCohort(EditID)
		echo("</div>")	
	case else
	
	end select

end function

function manageResources
	echo("manageResources")
end function


function selectCohort(CohortIDinput, inputName)
	sql = "select fldID, fldCohortName from tblCohorts where fldStatus = ?"
	Set cmd = Server.CreateObject("ADODB.Command")    
		cmd.ActiveConnection = cnnR
		cmd.CommandText = sql
		cmd.CommandType = adCmdText
		cmd.Parameters(0) = 1
	
	Set rs = cmd.Execute()
		if (rs.eof or rs.bof) then
			echo("error loading cohort data")
		else
			rsArr = rs.GetRows()
			echo("<label class=""select"">")
			echo("	<select class=""form-control"" name="""&inputName&""" required>")
			echo("		<option selected disabled>Select Cohort</option>")
			echo("		<option value=""0"" "&optionchecker(0, CohortIDinput)&">All Cohorts</option>")
			For a = LBound(rsArr, 2) To UBound(rsArr, 2)
				CohortID = rsArr(0,a)
				CohortName = rsArr(1,a)
				echo("		<option value="""&CohortID&""" "&optionchecker(CohortID, CohortIDinput)&">"&CohortName&"</option>")
			Next
			echo("	</select>")
			echo("</label>")
					
		end if

end function

function selectRole(RoleIDinput, inputName)
	sql = "select fldID, fldRoleName from tblRoles where fldStatus = ?"
	Set cmd = Server.CreateObject("ADODB.Command")    
		cmd.ActiveConnection = cnnR
		cmd.CommandText = sql
		cmd.CommandType = adCmdText
		cmd.Parameters(0) = 1
	
	Set rs = cmd.Execute()
		if (rs.eof or rs.bof) then
			echo("error loading role data")
		else
			rsArr = rs.GetRows()
			echo("<label class=""select"">")
			echo("	<select class=""form-control"" name="""&inputName&""" required>")
			echo("		<option selected disabled>Select Role</option>")
			For a = LBound(rsArr, 2) To UBound(rsArr, 2)
				RoleID = rsArr(0,a)
				RoleName = rsArr(1,a)
				echo("		<option value="""&RoleID&""" "&optionchecker(RoleID, RoleIDinput)&">"&RoleName&"</option>")
			Next
			echo("	</select>")
			echo("</label>")
					
		end if

end function

function selectStatus(StatusID)
	sql = "select * from tblStatus"
	Set cmd = Server.CreateObject("ADODB.Command")    
		cmd.ActiveConnection = cnnR
		cmd.CommandText = sql
		cmd.CommandType = adCmdText
	
	Set rs = cmd.Execute()
		if (rs.eof or rs.bof) then
			echo("error loading status table data")
		else
			rsArr = rs.GetRows()
			echo("<label class=""select"">")
			echo("	<select class=""form-control"" name=""frmStatus"" required>")
			echo("		<option selected disabled>Select Status</option>")
			For a = LBound(rsArr, 2) To UBound(rsArr, 2)
				'parentID = rsArr(0,a)
				StatusValue = rsArr(0,a)
				StatusTitle = rsArr(1,a)
				echo("		<option value="""&StatusValue&""" "&optionchecker(StatusValue, StatusID)&">"&StatusTitle&"</option>")
			Next
			echo("	</select>")
			echo("</label>")
					
		end if

end function

function showMembersInCohort(CohortID)
sql ="Select fldID, fldEmail, fldFirstName, fldLastName from tblMembers where fldCohortID = ? and fldStatus = ?" 
					
	Set cmd = Server.CreateObject("ADODB.Command")    
		cmd.ActiveConnection = cnnR
		cmd.CommandText = sql
		cmd.CommandType = adCmdText
		cmd.Parameters(0) = CohortID
		cmd.Parameters(1) = 1
	
	Set rs = cmd.Execute()
	if (rs.eof or rs.bof) then
		if CohortID <> 0 then
			w("No members have been found for this cohort")
		end if
	else
		rsArr = rs.GetRows()
		echo("<h4>Cohort Members</h4>")
		For a = LBound(rsArr, 2) To UBound(rsArr, 2)
			memberID = rsArr(0,a)
			memberEmail = rsArr(1,a)
			memberName = rsArr(2,a)&" "&rsArr(3,a)
			w(memberName)
		Next
	end if
end function
%>
