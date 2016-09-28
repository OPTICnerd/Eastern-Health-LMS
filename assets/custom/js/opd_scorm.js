// OPD SCORM Wrapper JavaScript 
// v 0.0.1 
// Todd Pardy

var xhttp = new XMLHttpRequest();
xhttp.onreadystatechange = function() {
"use strict";
   if (this.readyState === 4 && this.status === 200) {
       getSCORMversion(this);
	   //console.log(scorm_version);
   }
};
xhttp.open("GET", "scorm_package/imsmanifest.xml", true);
xhttp.send();

function getSCORMversion(xml) {
	// This will look in the course imsmanifest.xml file to see what version of SCORM the course is running
	// The API calls are different depending on the version of SCORM 
	
	var x, i, attnode, xmlDoc, scorm_version;
    xmlDoc = xml.responseXML;
    scorm_version = "";
    x = xmlDoc.getElementsByTagName('schemaversion');
    for (i = 0; i < x.length; i++) { 
        scorm_version += x[i].childNodes[0].nodeValue;
    }
	
	document.getElementById("scorm_version").value = scorm_version; 
	
	
}



function saveData(model, value) {
	
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
		var CourseInteractionID;
		//console.log(model);
	
		switch(model) {
			case "cmi.core.session_time":
				//code block
				break;
			case "cmi.suspend_data":
				//console.log("bookmark!");
				//console.log(model+" ** "+value+"'"); 
				var url = "https://easternhealth.mycpd.ca/lms/scorm.asp?a=2&bookmark="+value+"&course="+courseID+"&mem="+memID+"";
				//console.log(url);
        		xhr.open('POST', url, true);
       			xhr.send('');
				break;
		
			case "cmi.interactions.0.objectives.0.id":
				//console.log("objectives ID!");
				//console.log(model+" ** "+value+"'");
				//Cookies.set('CourseInteractionID', value);
				//var CourseInteractionID = value;
				
				//var url = "https://easternhealth.mycpd.ca/lms/scorm.asp?a=3&course="+courseID+"&mem="+memID+"";
        		//xhr.open('POST', url, true);
       			//xhr.send('');
				break;
			case "cmi.interactions.0.id":
				//console.log("objectives ID!");
				//console.log(model+" ** "+value+"'");
				Cookies.set('CourseInteractionID', value);
				//var CourseInteractionID = value;
				
				//var url = "https://easternhealth.mycpd.ca/lms/scorm.asp?a=3&course="+courseID+"&mem="+memID+"";
        		//xhr.open('POST', url, true);
       			//xhr.send('');
				break;	
			case "cmi.interactions.0.student_response":
				//console.log(model+" ** "+value+"'"); 
				Cookies.set('CourseInteractionResponse', value);
				break;
			case "cmi.interactions.0.result":
				Cookies.set('CourseInteractionResult', value);
				break;
			case "cmi.interactions.0.correct_responses.0.pattern":
				Cookies.set('CourseInteractionAnswer', value);
				console.log(model+" ** "+value+"'"); 
				break;
			case "cmi.core.score.raw":
				Cookies.set('CourseInteractionScore', value);
				break;
			case "cmi.core.lesson_status":
				//console.log("lesson status!");
				//console.log(model+" ** "+value+"'"); 
				
				var url = "https://easternhealth.mycpd.ca/lms/scorm.asp?a=1&status="+value+"&course="+courseID+"&mem="+memID+"";
        		xhr.open('POST', url, true);
       			xhr.send('');
				
				break;
			case "cmi.core.score.min": // should be last item in the interaction collection
				var CourseInteractionID = Cookies.get('CourseInteractionID');
				var CourseInteractionResult = Cookies.get('CourseInteractionResult');
				var CourseInteractionResponse = Cookies.get('CourseInteractionResponse');
				var CourseInteractionAnswer = Cookies.get('CourseInteractionAnswer');
				var CourseInteractionScore = Cookies.get('CourseInteractionScore');
				console.log(CourseInteractionID+" ** "+CourseInteractionResult+" ** "+CourseInteractionResponse+" ** "+CourseInteractionAnswer+" ** "+CourseInteractionScore); 
				
				// remove cookie when fired
				Cookies.remove('CourseInteractionID'); 
				Cookies.remove('CourseInteractionResult'); 
				Cookies.remove('CourseInteractionResponse'); 
				Cookies.remove('CourseInteractionAnswer'); 
				Cookies.remove('CourseInteractionScore'); 
				
			default:
				//var url = "https://2016.mycpd.ca/eh/submit.asp?appKey=BXZ5GvMJpxZJLLuc3763&a=1&status="+model+","+value+"&mem="+memID+"";
        		//xhr.open('POST', url, true);
       			//xhr.send('');
				
				console.log(CourseInteractionScore); 
				//console.log(model+" ** "+value+"'"); 
				
		}
        	
}
