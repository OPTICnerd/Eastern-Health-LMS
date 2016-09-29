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
<input type="hidden" value="<%=session("memberID") %>" id="memberID">
<input type="hidden" value="<%= LMSid %>" id="LMSid">
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
	Initialize: function() {
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
		font-family:Gotham, "Helvetica Neue", Helvetica, Arial, sans-serif;
		padding: 0;
		margin: 0;
		
	}
	
    #warning-message { display: none; }
    @media only screen and (orientation:portrait){
		body{
			background: #000;
			font-family:Gotham, "Helvetica Neue", Helvetica, Arial, sans-serif;
			padding: 20px;
			margin: 0;
			color:#FFFFFF;
			
		}
        #wrapper { display:none; }
        #warning-message { 
			display:block; 
			text-align:center;
			font-size:14px;
			font-weight:bold;
			}
    }
    @media only screen and (orientation:landscape){
        #warning-message { display:none; }
    }


</style>
<div id="warning-message">
    <div align="center">
    <p>This course is only viewable in landscape mode. </p>
    
    <img src="/assets/custom/images/mobile-orientation.png" width="216" height="208" alt=""/>
    <p>please turn your phone or device.</p>
    </div>
</div>
<div id="wrapper">
   

<iframe id="course_source" src="" allowtransparency='true' scrolling='no' frameborder='0' seamless style="position:fixed; top:0px; left:0px; bottom:0px; right:0px; width:100%; height:100%; border:none; margin:0; padding:0; overflow:hidden; z-index:999999;"></iframe>
</div>