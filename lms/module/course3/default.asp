<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	set cnnR = Server.CreateObject("ADODB.Connection")
	cnnR.Open Application("DataBase")
	PageName = "Course Holder"
	PageType = "course"
%>
<!--#include file="../../../lib/master.asp" -->
<!--#include file="../../../lib/scorm_code.asp" -->
<%
sql = "select fldBookmarkValue from tblBookMark where fldLMSid = ? and fldMemberID = ?"
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = Application("DataBaseW")
	cmd.CommandText = sql
	cmd.CommandType = adCmdText
	cmd.Parameters(0) = LMSid
	cmd.Parameters(1) = session("memberID")
	Set rs = cmd.Execute()
	if (rs.eof or rs.bof) then ' new entry so do insert
		courseBookmark = ""
	else
		courseBookmark = rs("fldBookmarkValue")
	end if


' check and see if there is a bookmark in the db
%>
<input type="text" value="<%=session("memberID") %>" id="memberID">
<input type="text" value="<%= LMSid %>" id="LMSid">
<script>
function GetStudentName() {
	return "<%=session("cmi.core.student_name")%>";
};
</script>

<script type="text/javascript">
// Office of Professional Development (OPD)  SCORM Javascript File
window.API = (function(){
  var data = {
    "cmi.core.student_id": "<%=session("cmi.core.student_id")%>",
    "cmi.core.student_name": "<%=session("cmi.core.student_name")%>",
    "cmi.core.lesson_location": "",
    "cmi.core.lesson_status": "not attempted",
	"cmi.suspend_data" : "<%= courseBookmark %>"
  };
  return {
    LMSInitialize: function() {
      return "true";  
    },
    LMSCommit: function() {
		var xhr;
   
        if(typeof XMLHttpRequest !== 'undefined') xhr = new XMLHttpRequest();
        else {
            var versions = ["MSXML2.XmlHttp.5.0", 
                            "MSXML2.XmlHttp.4.0",
                            "MSXML2.XmlHttp.3.0", 
                            "MSXML2.XmlHttp.2.0",
                            "Microsoft.XmlHttp"]
 
             for(var i = 0, len = versions.length; i < len; i++) {
                try {
                    xhr = new ActiveXObject(versions[i]);
                    break;
                }
                catch(e){}
             } // end for
        }
         
        xhr.onreadystatechange = ensureReadiness;
         
        function ensureReadiness() {
            if(xhr.readyState < 4) {
                return;
            }
             
            if(xhr.status !== 200) {
                return;
            }
 
            // all is well  
            if(xhr.readyState === 4) {
                //callback(xhr);
            }           
        }
    },
    LMSFinish: function() {
		
      return "true"; 
	   
    },
    LMSGetValue: function(model) {
      return data[model] || "";
    },
    LMSSetValue: function(model, value) {
      data[model] = value;
	  //alert(model+':'+value);
	  // let's fire this with ajax
	  //if (data[model] = "'cmi.suspend_data'") {
	//	console.log("the data to save is '"+model+" ** "+value+"'");  
	//	saveBookmark(model,value);
	//  }
	  
	  if (data[model] = "'cmi.core.lesson_status'") {
		 
		//saveLessonStatus(model,value);
	  }
	  console.log(model+" ** "+value+"'"); 
	  saveDataStatus(model,value);
	  
      return "true";
    },
    LMSGetLastError: function() {
      return "0";
    },
    LMSGetErrorString: function(errorCode) {
      return "No error";
    },
    LMSGetDiagnostic: function(errorCode) {
      return "No error";
    }
  };
})();

function saveBookmark(model, value) {
	var courseID = document.getElementById('LMSid').value;
	var memID = document.getElementById('memberID').value;
	var xhr;
   
        if(typeof XMLHttpRequest !== 'undefined') xhr = new XMLHttpRequest();
        else {
            var versions = ["MSXML2.XmlHttp.5.0", 
                            "MSXML2.XmlHttp.4.0",
                            "MSXML2.XmlHttp.3.0", 
                            "MSXML2.XmlHttp.2.0",
                            "Microsoft.XmlHttp"]
 
             for(var i = 0, len = versions.length; i < len; i++) {
                try {
                    xhr = new ActiveXObject(versions[i]);
                    break;
                }
                catch(e){}
             } // end for
        }
         
        xhr.onreadystatechange = ensureReadiness;
         
        function ensureReadiness() {
            if(xhr.readyState < 4) {
                return;
            }
             
            if(xhr.status !== 200) {
                return;
            }
 
            // all is well  
            if(xhr.readyState === 4) {
                //callback(xhr);
            }           
        }

        var url = "https://easternhealth.mycpd.ca/lms/scorm.asp?appKey=BXZ5GvMJpxZJLLuc3763&a=2&bookmark="+model+","+value+"&course="+courseID+"&mem="+memID+"";
        xhr.open('POST', url, true);
        xhr.send('');	
}


function saveDataStatus(model, value) {
	
	var courseID = document.getElementById('LMSid').value;
	var memID = document.getElementById('memberID').value;
	var xhr;
   
        if(typeof XMLHttpRequest !== 'undefined') xhr = new XMLHttpRequest();
        else {
            var versions = ["MSXML2.XmlHttp.5.0", 
                            "MSXML2.XmlHttp.4.0",
                            "MSXML2.XmlHttp.3.0", 
                            "MSXML2.XmlHttp.2.0",
                            "Microsoft.XmlHttp"]
 
             for(var i = 0, len = versions.length; i < len; i++) {
                try {
                    xhr = new ActiveXObject(versions[i]);
                    break;
                }
                catch(e){}
             } // end for
        }
         
        xhr.onreadystatechange = ensureReadiness;
         
        function ensureReadiness() {
            if(xhr.readyState < 4) {
                return;
            }
             
            if(xhr.status !== 200) {
                return;
            }
 
            // all is well  
            if(xhr.readyState === 4) {
                //callback(xhr);
            }           
        }
		var courseID = document.getElementById('LMSid').value;
		var memID = document.getElementById('memberID').value;
		//console.log(model);
		switch(model) {
			case "cmi.core.session_time":
				//code block
				break;
			case "cmi.suspend_data":
				console.log("save bookmark");
				
				var url = "https://easternhealth.mycpd.ca/lms/scorm.asp?a=2&bookmark="+value+"&course="+courseID+"&mem="+memID+"";
				console.log(url);
        		xhr.open('POST', url, true);
       			xhr.send('');
				break;
				//code block
				break;
			case "cmi.interactions.0.objectives.0.id":
				var url = "https://easternhealth.mycpd.ca/lms/scorm.asp?a=3&course="+courseID+"&mem="+memID+"";
        		xhr.open('POST', url, true);
       			xhr.send('');
				break;
			
			case "cmi.core.lesson_status":
				var url = "https://easternhealth.mycpd.ca/lms/scorm.asp?a=1&status="+value+"&course="+courseID+"&mem="+memID+"";
        		xhr.open('POST', url, true);
       			xhr.send('');
				
				break;
			default:
				//var url = "https://2016.mycpd.ca/eh/submit.asp?appKey=BXZ5GvMJpxZJLLuc3763&a=1&status="+model+","+value+"&mem="+memID+"";
        		//xhr.open('POST', url, true);
       			//xhr.send('');
		}
        	
}

</script>
<style>
	body{
		background: #d1dfea;
		padding: 0;
		margin: 0;
	}
</style>
<iframe src="scorm_package/index_lms_html5.html" width=1050 height=670 frameborder="0" seamless></iframe>
