<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	set cnnR = Server.CreateObject("ADODB.Connection")
	cnnR.Open Application("DataBase")
	PageName = "Course Holder"
	PageType = "course"
%>
<!--#include file="../../../lib/master.asp" -->
<!--#include file="../../../lib/scorm_code.asp" -->
<script src="/assets/custom/js/opd_scorm.js"></script>
<input type="text" value="<%=session("memberID") %>" id="memberID">
<input type="text" value="<%= LMSid %>" id="LMSid">
<input type="text" id="scorm_version">
<script>
function GetStudentName() {
	return "<%=session("cmi.core.student_name")%>";
};
</script>

<script type="text/javascript">
// Office of Professional Development (OPD)  SCORM Javascript File

//console.log(scorm.version);

window.API = (function(){
  var data = {
    "cmi.core.student_id": "<%=session("cmi.core.student_id")%>",
    "cmi.core.student_name": "<%=session("cmi.core.student_name")%>",
    "cmi.core.lesson_location": "",
    "cmi.core.lesson_status": "not attempted",
	"cmi.suspend_data" : "<%= getBookMark(LMSid) %>"
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
	  
	  saveData(model,value);
	  
      return "true";
    },
    LMSGetLastError: function() {
      return "X0X";
    },
    LMSGetErrorString: function(errorCode) {
      return "No error";
    },
    LMSGetDiagnostic: function(errorCode) {
      return "No error";
    }
  };
})();

</script>
<style>
	body{
		background: #d1dfea;
		padding: 0;
		margin: 0;
	}
</style>
<iframe src="scorm_package/index_lms_html5.html" width=1050 height=670 frameborder="0" seamless></iframe>
