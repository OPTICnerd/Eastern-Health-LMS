	var output = "<div class='clipboardtop'></div>";
	var parms;
	var casetype = [];
	var screen_name = [];
	var defaulttxt = [];
	var qcount = [];
	var fcount = [];
	var tblhead = [];
	var tblhead2 = [];
	var resultsource = [];
	var resultdest = [];
	var tabhead = [];
	var question = [];
	var feedback = [];
	var folquestion = [];
	var folfeedback = [];
	var hotspot = [];
	var txt;
	var testRdo = [];
	var fillRdo = [];
	var chkStrRdo = [];
	var q_db = [];
	var qi = 0;
	var selectedKeys = [];
	
	function resetCase() {
		//alert("reset");
		$(".screens").hide();
		$(".fb").hide();
		$('img[src$="arr1.png"]').hide();
		$('input:checkbox').removeAttr('checked');
		$("#screen0").fadeIn();	
	}
	
	
	for(var s=0; s<=screencount; s++) {
		
		parms = case_screen[s].val.split("|");
		casetype[s] = parms[0];
		screen_name[s] = parms[1];
		defaulttxt[s] = parms[2];
		qcount[s] = parms[3]-1;
		tblhead[s] = parms[4];
		tblhead2[s] = parms[5];
		resultsource[s] = parms[6];
		tabhead[s] = parms[7];
		resultdest[s] = parms[8];
		question[s] = [];
		feedback[s] = [];
		fcount[s] = [];
		hotspot[s] = [];
	
		output += "<div class='screens' id='screen"+s+"'>";		
		
	// build reset and progress buttons
	output += "<div class='historyLink'><div class='historyLinkInner'><input type=button id='submitReset"+s+"' style='display:none' onclick='resetCase();'><input type='hidden' name='a' value='resetCase'/><input type='hidden' name='case_name' value='"+case_name+"'/><input type='hidden' name='screen_no' value='"+s+"'/>";
	output += "<a href='#' onclick='$(\"#submitReset"+s+"\").click();' class='caseButton caseReset'></a>";
	output += "<a href='#' onclick='return progressToggle("+s+");' class='caseButton caseProgress'></a>";
	output += "<a href='#' onclick='return casehistoryToggle("+s+");' class='caseButton caseHistory'></a>";
	output += "</div></div>";
	
	output += "<div class='hist' id='history"+s+"'><div style='float:right;'><a href='#' onclick='return progressToggle("+s+");'>X</a></div>";
	
	// build history list	
	for(var ss=0; ss<=s; ss++) {	
		var parmss = case_screen[ss].val.split("|");
		screen_name[ss] = parmss[1];
		output += "<a href='#' onclick='$(\".screens\").fadeOut(\"fast\");$(\"#screen"+ss+"\").fadeIn(\"slow\");$(\".hist\").fadeOut(\"fast\");'>"+screen_name[ss]+"</a><br>";
		if (ss<s) output+= "<br>"
	}
	output += '</div>';
	
	// build Case History
	var casehistory = "<div class='hist casehist' id='casehistory"+s+"'><div style='float:right;'><a href='#' onclick='return casehistoryToggle("+s+");'>X</a></div><strong>Case History</strong><br><img src='"+img_caseicon+"' align='left' style='margin:0 5px 0 0'>"+txt_casehistory+"</div>";
	
	// add case history to output
	output += casehistory;
		
		//begin build form
		output += "<div class='defaulttxt'><img src='"+img_caseicon+"' align='left' class='imgthumb'><strong>" + screen_name[s] +"<br>"+ defaulttxt[s] + "</strong></div><br><form name='caseform"+s+"' onsubmit=\"$('html, body').animate({scrollTop:$('.scrollContainerCaseplayer').offset().top - 20}, 'slow');\"><input type='hidden' name='a' value='saveScreen'/><input type='hidden' name='case_name' value='"+case_name+"'/><input type='hidden' name='screen_no' value='"+s+"'/><input type='hidden' id='qcount_"+s+"' name='qcount' value='"+((qcount[s]*1)+1)+"'/><input type='hidden' id='qstart_"+s+"' name='qstart' value='0'/><input type='hidden' name='resultsource' value='"+resultsource[s]+"'/><table class='QTable'><tr><td>"+tblhead[s]+"</td><td>"+tblhead2[s]+"</td></tr>";
										
		for(var i=0; i<=qcount[s]; i++) {
			//alert(i);
			txt = case_screen[s].questions[i].val.split("|");
			question[s][i] = txt[0];
			feedback[s][i] = txt[1];
			fcount[s][i] = txt[2]-1;
			hotspot[s][i] = [];	
			if (casetype[s]==0) {				
				if (feedback[s][i]=='LIKERTSCALE') {
					
					// generate the likert scale radio buttons / slider
					output += "<tr><td width='35%'><input type='hidden' name='feedback_"+i+"' value='"+feedback[s][i]+"'/><div id='q"+i+"' class='q'><label><input name='chk_q"+i+"' id='chk_s"+s+"_q"+i+"' type=checkbox onclick=\"$('#"+s+"_"+"ls"+i+"').toggle('fast');checkFFB("+s+","+i+");\" value='1'> "+question[s][i]+"</label></div><input type='hidden' id='fcount_"+s+"_"+i+"' name='fcount_"+i+"' value='"+fcount[s][i]+"'/></td>" ;
					q_db[qi] = "chk_s"+s+"_q"+i;
					qi++;
					output += "<td class='tdls'><div id='"+s+"_ls"+i+"' class='ls'>";
					for(var r=1; r<=5; r++) {
						
						output += "<label class='rdo_ls'>[ "+r+" <input type=radio id='chk_s"+s+"_q"+i+"_"+r+"' name='chk_q"+i+"_ls' class='ls"+s+"_"+i+"' onclick=\"getLikertVal("+s+","+i+");\" value='"+r+"' "+chkStrRdo[r]+"> ]</label> - ";
					}
					output += "</div></td></tr>";
				} else {
					var varHide = "";
					if(question[s][i]=="null") varHide="style='display:none'";
					//output the checkbox for most other cases.. 'non-likert case' 'type 1' screens
					output += "<tr "+varHide+"><td width='35%'><input type='hidden' name='feedback_"+i+"' value=''/><div id='q"+i+"' class='q'><label><input id='chk_s"+s+"_q"+i+"' name='chk_q"+i+"' type=checkbox onclick=\"$('#"+s+"_"+"fb"+i+"').toggle('fast');$('."+s+"_"+"fq"+i+"').toggle('fast');checkFFB("+s+","+i+");\" value='1'> "+question[s][i]+"</label></div><input type='hidden' id='fcount_"+s+"_"+i+"' name='fcount_"+i+"' value='"+fcount[s][i]+"'/>" ;
					q_db[qi] = "chk_s"+s+"_q"+i;
					qi++;
					if (fcount[s][i]<-1) {	
						var examcount = (fcount[s][i]*(-1))-2;
						for(var j=0; j<=examcount; j++) {
							output += "<input class='vchk' alt='chk_s"+s+"_q"+i+"_f"+j+"' type=hidden id='vchk_s"+s+"_q"+i+"_f"+j+"' name='vchk_q"+i+"_f"+j+"' value='0'>";
							q_db[qi] = "vchk_s"+s+"_q"+i+"_f"+j;
							qi++;
						}
					}
					output += "</td>";		
					output += "<td class='tdfb'><div id='"+s+"_fb"+i+"' class='fb'>" + feedback[s][i] +"</div></td></tr>";
				}	
			} else if(casetype[s]==1) {	
					// LABORATORY RESULTS
					output += "<tr class='revchk_s"+resultsource[s]+"_q"+i+"' style='display:none'><td width='35%'>" ;							
					output += "<div class='revchk_s"+resultsource[s]+"_q"+i+"' style='display:none'>";
					output += question[s][i]+"</div></td>" ;
					output += "<td class='tdfb'>";								
					output += "<div class='revchk_s"+resultsource[s]+"_q"+i+"' style='display:none'>";		
					output += feedback[s][i] +"</div><input type='hidden' name='feedback_"+i+"' value='"+feedback[s][i]+"'/><input type='hidden' id='fcount_"+s+"_"+i+"' name='fcount_"+i+"' value='"+fcount[s][i]+"'/></td></tr>";	
					qi++;			
			} else if(casetype[s]==2) {	
			
					// ---- begin CASE REVIEW --------------------------------
					
					output += "<tr><td colspan=2>" ;					
					output += "<ul class='tabs-nav'>" ;
					for(var x=0; x<=pre_review_count; x++) {
						var varHide = "";
						// if(question[x][0]=="null") varHide="style='display:none'"; // use this if we want to hide Feedback tab
						if(x==0) {output += "<li class='active'><a href='#tab0' class='t0'>" ;}
						else { output += "<li "+varHide+"><a href='#tab"+x+"' class='t"+x+"'>" ; }	
						output += tabhead[x] ;							
						output += "</a></li>" ;							
					}
					output += "</ul><div class='tabs-container'>" ;
					
					// cycle through screens leading up to CASE REVIEW
					for(var x=0; x<=pre_review_count; x++) {
						//create tabs
						output += "<div class='tab-content' id='tab"+x+"'>" ;
						
						// create table headers
						if(casetype[x]==1) {
							output += "<table class='QTable' border='0' cellspacing='0' cellpadding='0'><tr><td width='45%' valign='top'><p>"+tblhead[x]+"</p></td><td width='50%' valign='top'><p>"+tblhead2[x]+"</p></td><td width='5%' valign='top'><p>Your Rating</p></td></tr>" ;
						} else if(feedback[x][0]=='LIKERTSCALE') {
							output += "<table class='QTable' border='0' cellspacing='0' cellpadding='0'><tr><td width='95%' valign='top' colspan=2><p>"+tblhead[x]+"</p></td><td width='5%' valign='top'><p>Your Rating</p></td></tr>" ;
						} else if(question[x][0]=="null") {
							output += "<table class='QTable' border='0' cellspacing='0' cellpadding='0'><tr><td width='100%' valign='top' colspan=3><p>Feedback</p></td></tr>" ;							
						} else {
							output += "<table class='QTable' border='0' cellspacing='0' cellpadding='0'><tr><td width='50%' valign='top'><p>"+tblhead[x]+"</p></td><td width='50%' valign='top' colspan=2><p>"+tblhead2[x]+"</p></td></tr>" ;
						}
						
						folquestion[x] = [];
						folfeedback[x] = [];			
						
						//cycle through questions to place on each tab					
						for(var q=0; q<=qcount[x]; q++) {									
							// .. casetype=1 requires getting data from another screen,
							// so we use resultsource[x] if casetype=1		
							var xx = (casetype[x]==1)?resultsource[x]:x;
							if(feedback[x][0]=='LIKERTSCALE') {	
								output += "<tr><td width='80%' valign='top' colspan=2>";						
								output += "<img class='revchk_s"+xx+"_q"+q+"'";
								output += " src='arr1.png' style='display:none'> ";				
								output += question[xx][q] ;
							} else if(question[x][0]=="null") {	
								output += "<tr><td width='100%' valign='top' colspan=3>";
								output += defaulttxt[x];
							} else {
								output += "<tr><td width='40%' valign='top'>";					
								output += "<img class='revchk_s"+xx+"_q"+q+"'";
								output += " src='arr1.png' style='display:none'> ";								
								output += question[xx][q] ;	
								output += "</td><td width='40%' valign='top'>";			
								if (fcount[xx][q]>-2) output += feedback[x][q] ;					
							}	
							if((casetype[x]==1) || (feedback[x][0]=='LIKERTSCALE')) {
								// .. need to show ratings columns			
								output += "</td><td width='5%' valign='top' align='center'> <span class='revlik_s"+xx+"_q"+q+"'></span></td></tr>" ;
							}
							
							folquestion[x][q] = [];
							folfeedback[x][q] = [];	
							
							//cycle through and list any followup questions
							for(var j=0; j<=fcount[x][q]; j++) {
								txt = case_screen[x].questions[q].followup[j].val.split("|");
								folquestion[x][q][j] = txt[0];
								folfeedback[x][q][j] = txt[1];
								output += "<tr><td width='50%' valign='top'>";	
								output += "<img class='revchk_s"+x+"_q"+q+"_f"+j+"'";
								output += " src='arr1.png' style='display:none'> ";
								output += folquestion[x][q][j] ;					
								//output += " ("+x+","+q+","+j+")" ;
								output += "</td><td width='50%' valign='top' colspan=2>";					
								output += folfeedback[x][q][j] ;						
								output += "</td></tr>" ;								
							}
							// setup hotspot fields in review screen
							if (fcount[x][q]<-1) {	
								var examcount = (fcount[x][q]*(-1))-2;
								for(var j=0; j<=examcount; j++) {
									txt = case_screen[x].questions[q].exam[j].val.split("|");
									folquestion[x][q][j] = txt[2];	
									folfeedback[x][q][j] = txt[1];				
									output += "<tr><td width='40%' valign='top'>";	
									output += "<img class='revchk_s"+x+"_q"+q+"_f"+j+"'";
									output += " src='arr1.png' style='display:none'> ";
									output += folquestion[x][q][j] ;
									output += "</td><td width='40%' valign='top'>";					
									output += folfeedback[x][q][j] ;										
									output += "</td><td width='20%' valign='top' align='center'> <span id='per_"+x+"_"+q+"_"+j+"'></span></td></tr>" ;
								}	
							}
						}
						/// --- end case review -----------------------------------
						output += "</table>" ;
						output += "</div>" ;					
					}
					output += "</div>" ;					
					output += "</td>" ;
			}
									
			// parse out followup questions	
			folquestion[s] = [];
			folfeedback[s] = [];						
			for(var j=0; j<=fcount[s][i]; j++) {
				txt = case_screen[s].questions[i].followup[j].val.split("|");
				folquestion[s][j] = txt[0];
				folfeedback[s][j] = txt[1];
				output += "<tr class='"+s+"_fq"+i+"' style='display:none'><td class='tdfq'><div id='"+s+"_fq"+j+"' class='fq'><label><input id='chk_s"+s+"_q"+i+"_f"+j+"' name='chk_q"+i+"_f"+j+"' class='chk_fq "+s+"_chk_fq"+i+"' type=checkbox onclick=\"$('#"+s+"_"+i+"ffb"+j+"').toggle('fast');revFBQ("+s+","+i+","+j+");\" value='1'> "+folquestion[s][j]+"</label></div></td>";					
				q_db[qi] = "chk_s"+s+"_q"+i+"_f"+j;
				qi++;			
				output += "<td class='tdfb'><div id='"+s+"_"+i+"ffb"+j+"' class='ffb "+s+"_ffb"+i+"'>" + folfeedback[s][j] +"</div></td></tr>";
			}	
		}
		output += "</table><br><div class='navbuttons'>";
		if (s>0 && s!=screencount) output += "<input type='button' style='float:left' onclick='$(\"html, body, .scrollContainerCaseplayer\").animate({scrollTop: \"0px\"}, 200);$(\"#screen"+s+"\").hide();$(\"#screen"+(s*1-1)+"\").fadeIn(\"slow\");$(\".hist\").fadeOut(\"fast\");return false;' value='<< Previous Step'>";
		if (s<screencount) {
			if (s==(screencount-1)) {
				output += "<input type='button' style='float:right' onclick='$(\"html, body, .scrollContainerCaseplayer\").animate({scrollTop: \"0px\"}, 200);$(\"#screen"+s+"\").hide();$(\"#screen"+(s*1+1)+"\").fadeIn(\"slow\");shownav();$(\".hist\").fadeOut(\"fast\");' value='Next Step >>'>";
			}else {
				output += "<input type='button' style='float:right' onclick='$(\"html, body, .scrollContainerCaseplayer\").animate({scrollTop: \"0px\"}, 200);$(\"#screen"+s+"\").hide();$(\"#screen"+(s*1+1)+"\").fadeIn(\"slow\");$(\".hist\").fadeOut(\"fast\");' value='Next Step >>'>";
			}
		}
		output += "</div></form>";
		output += "</div>";
	}
		//output += "<button onclick='alert(\""+q_db[0]+"\")'></button>";
		//output += "<button onclick='alert(\""+q_db[18]+"\")'></button>";

output += "<div class='clipboardbottom'></div>";
			

//ajax({a:'loadScreen', case_name:case_name});
//ajax({a:'loadLikert', case_name:case_name});
//ajax({a:'loadPercentage', case_name:case_name});
//ajax({a:'loadRating', case_name:case_name});
for(var i=0; i<=(screencount-1); i++) {
	//incQStart(i);
}

//$joint_map.mapster('set', true, 'chk_s1_q1_f0');

document.write(output);

  



function getLikertVal(s,i) {
    $("#"+s+"_ls"+i+" :radio:checked").map(function() {
        return $(this);  
    }).each(function() {
		if ($('#chk_s'+s+'_q'+i).attr('checked')=='checked') {
			$('.revlik_s'+s+'_q'+i).replaceWith("<span class='revlik_s"+s+"_q"+i+"'>"+this.val()+"</span>");
			if (resultdest[s]>0) {
				$('#chk_s'+resultdest[s]+'_q'+i+'_'+this.val()).attr("checked","checked");
				$('.revlik_s'+resultdest[s]+'_q'+i).replaceWith("<span class='revlik_s"+resultdest[s]+"_q"+i+"'>"+this.val()+"</span>");
			}
		}		
    });
}

function checkFFB(s,i) {
	//if unchecking a question, uncheck followup quesions and hide followup feedback
	if ($('.'+s+'_fq'+i).attr('display')!='visible') {
		$('.'+s+'_chk_fq'+i).removeAttr('checked');
		$('.'+s+'_ffb'+i).hide('fast');
		$('.revlik_s'+s+'_q'+i).replaceWith("<span class='revlik_s"+s+"_q"+i+"'></span>");
	}	
	//toggle the review checkbox
	if ($('#chk_s'+s+'_q'+i).attr('checked')=='checked') {
		if (feedback[s][i]=='LIKERTSCALE') {
			if (resultdest[s]>0) {
				$('#chk_s'+resultdest[s]+'_q'+i).attr("checked","checked");	
				$("#"+resultdest[s]+"_ls"+i).toggle('fast');
			}	
		}
		$('.revchk_s'+s+'_q'+i).css('display','');
		if (resultdest[s]>0) {
			$('.revchk_s'+resultdest[s]+'_q'+i).css('display','');
		}
   		$("#"+s+"_ls"+i+" :radio:checked").map(function() {
     	   return $(this); 
    	}).each(function() {
			$('.revlik_s'+s+'_q'+i).replaceWith("<span class='revlik_s"+s+"_q"+i+"'>"+this.val()+"</span>");			
	    });		
	} else {
		$('.revchk_s'+s+'_q'+i).css('display','none');
		if (feedback[s][i]=='LIKERTSCALE') {
			for(var j=1; j<=5; j++) {
				$('#chk_s'+s+'_q'+i+'_'+j).removeAttr('checked');
				if (resultdest[s]>0) {
					$('#chk_s'+resultdest[s]+'_q'+i+'_'+j).removeAttr('checked');	
				}					
			}
		}
	}
}

function revFBQ(s,i,f) {
	//toggle the review checkbox
	if ($('#chk_s'+s+'_q'+i+'_f'+f).attr('checked')=='checked') {
		$('.revchk_s'+s+'_q'+i+'_f'+f).css('display','');
	} else {
		$('.revchk_s'+s+'_q'+i+'_f'+f).css('display','none');
	}
}

function progressToggle(sindex) {
	$('#casehistory'+sindex).hide();
	var hist = $('#history'+sindex);


	//if(!hist.is(':visible')) historyUpdate();
	hist.toggle();
	return false;
}

function casehistoryToggle(sindex) {
	$('#history'+sindex).hide();
	var hist = $('#casehistory'+sindex);
	hist.toggle();
	return false;
}

function incQStart(sc) {
	var nextsc = (sc*1)+1;
	var s = $('#qstart_'+sc).val();
	s = s*1;
	var c = $('#qcount_'+sc).val();
	c = c*1;	
	var fcount = 0;
	for(var i=0; i<=(c-1); i++) {
		var inputFcount = ($('#fcount_'+sc+'_'+i).val()*1)+1;
		//if(i==5) alert(inputFcount);
		if(inputFcount<0) inputFcount = (inputFcount*(-1));
		//if(i==5) alert(inputFcount);
		fcount += (inputFcount*1);
		//if(i==5) alert(fcount);
	}
	if(isNaN(fcount)) fcount=0;
	//if(isNaN(fcount)) alert(s+": NAN!");
	var q = s+c+fcount;
	//alert("q="+q+", s="+s+", c="+c+", fcount="+fcount);
	$('#qstart_'+nextsc).val(q);
}

function readyFn( jQuery ) {
                $('img[src$="back.png"]').hide();
                $('img[src$="next.png"]').hide();
}

$( window ).load(readyFn);

function shownav() {
                $('img[src$="back.png"]').show();
                $('img[src$="next.png"]').show();
}

 $(document).ready(function() {

	$('#screen0').fadeIn('fast');
	// Tabs:
	$(".tab-content").hide(); //Hide all content
	$("ul.tabs-nav li:first-child").addClass("active").show(); //Activate first tab
	$(".tab-content:first-child").show(); //Show first tab content	

	//On Click Event
	$("ul.tabs-nav li").click(function() {
		var li = $(this);
		var ul = li.parent();
		var tc = ul.next('.tabs-container');
		tc.css('min-height',tc.height()+'px');
		ul.children().removeClass("active"); //Remove any "active" class
		li.addClass("active"); //Add "active" class to selected tab
		tc.children(".tab-content").hide(); //Hide all tab content
		var activeTab = $(this).find("a").attr("href"); //Find the rel attribute value to identify the active tab + content
		//console.log(activeTab);
		tc.children(activeTab).fadeIn(); //Fade in the active content
		tc.css('min-height','');
		return false;
 	});

 	$("a[rel]").overlay();
 });