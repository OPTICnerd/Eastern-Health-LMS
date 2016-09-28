	// screen = "screen type  | page header text | number of questions | tblhead1 | tblhead2 | screen to get results from | tab name | screen to send results to"
	// questions = "question | feedback | number of follow questions"
	// followup = "question | feedback"
	
	var screencount=2; // zero-based
	var pre_review_count = 1 // zero-based
	var body_screen = 9;
	var body_q = 1;
	var case_name = "opioids_3b";
	var txt_casehistory = "<p>Cecily B, a 32yr old female, has been a patient of yours for  many years. Two years ago she underwent left hemilaminectomy at L5-S1 after  presenting with severe radicular symptoms not responsive to conservative  therapy. There were no complications following the surgery however her pain  scores, which were 2/10 post operatively, have been increasing over the last 2  years.</p><p>  Cecily tells you that her pain scores are currently at 8/10  and are consistently interfering with her ability to do housework, work full  time at a desk job, and care for her family. She has been getting increasingly  frustrated and anxious with regards to her pain and decreased function. She has  been managed previously by a pain specialist however he retired shortly after  Cecily&rsquo;s surgery. She has been desperate over the last few months and was  re-assessed by her surgeon who prescribed oxycodone 5mg/acetaminophen 325mg one  tablet qid prn, a two month supply with no repeats. Her surgeon advised her  there was nothing more he could offer and recommended follow up with her  general practitioner for ongoing medical management.</p><p>  Cecily comes to your office today for medication evaluation.  She states that her pain has worsened in the last month and the oxycodone  5mg/acetaminophen 325mg one tablet qid prn was not as beneficial as she had  hoped.&nbsp; She is wondering if there is  something stronger that she can take.</p>";
	var img_caseicon = "ImgCaseStudy-Cecily_thm.jpg";
	var wleft = ((document.width/2)-250);
	var wtop = ((document.height/2)-140);
	var mf = "female";
	var videoIcon = "<img src='video.png' width='20' align='left' class='videoIcon'>";
	
	var case_screen = [
	
   	{ val: "0|Step 1 of 3: Referring Cecily:|<br><p class='indentLR'>Cecily comes to your office for ongoing medical management of her radicular low back pain. You have been working with her over the last year in an attempt to improve her pain control and overall function. While she has made some progress (pain scores 30% less than previous, able to complete basic ADLS) she has been having difficulty working full time, shopping, or walking for any distances. While she has been doing reasonably well on her current medications, her pain control is barely adequate and she wishes to continue to work full time and remain active. You are uncomfortable increasing her Fentanyl patch dose of 75mcg/hr q 72hrs and decide to refer Cecily to a pain specialist to see whether any interventions or further medical pain control might be of benefit for Cecily's radicular back pain. </p><br><br><p class='indentLR eg' style='font-weight:bold;'>Click on the appropriate checkbox to complete Cecily’s referral. Once you have finished, click the <em>Next Step</em> button at the bottom of the clipboard to continue. </p>|3|Complete the referral|Feedback|0|Referral Screen|0", questions: [
        { val: "Details describing the patient's pain condition|32 yr female with previous L4-5 hemilaminectomy. Ongoing radicular symptoms. Current opioid dose (Fentanyl patch 75mcg/hr q 72hrs) is not providing adequate pain control and interfering with ADLs and sleep. She is at low risk of opioid abuse.|0", followup: [] },
        { val: "Actions undertaken to manage the pain and result|Physiotherapy, massage therapy, oxycodone CR 10mg Q12h, oxycodone 5mg/acetaminophen 325mg, morphine CR 60mg Q12h, acetaminophen/codeine; acetaminophen no longer tolerated due to GI upset. NSAIDs, coxibs, gabapentin and duloxetine were ineffective.|0", followup: [] },
        { val: "Specific requested action(s) for the consultant (e.g., confirm diagnosis, screen for risks or misuse, review and advise on need for opioids and dose)|Please assess for interventional procedure or further medical management options.|0", followup: [] }
   	] },
	
   { val: "0|Step 2 of 3: Feedback|<br><br><br><p class='indentLR'>For referrals, including patient pain scores and all related questionnaires and documentation, such as current BPI, is helpful to include on referral.  Specifics regarding the type of pain (burning, gnawing, sharp), location  of pain(low back with no radiation &ndash; mechanical vs. possible radicular symptoms),  and a list of all medication trials and dosages is extremely beneficial. Copies  of all investigations and imaging as well as any other consultation should also  be included.</p><br><p class='indentLR'>  Most consultations should be viewed as collaborative  care opportunities and not transfer of care. Specific questions are helpful to  determine capacity of involvement with the specialist. The general practitioner  should be open to considering all therapeutic suggestions and working with the  specialist regarding care of the patient. All psychosocial resources should be  utilized.</p>|1|||0|Feedback|0", questions: [{ val: "null||0", followup: [] }] },
	
   	{ val: "2|Step 3 of 3: REVIEW|<p class='indentLR'>Suggested review of the case pertaining to Management of Cecily. During this case, you have made several choices. The choices you have made are indicated by an arrow.</p><br>|1|||0||0", questions: [
        { val: "" }
   	] }
	];