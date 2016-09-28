// screen = "screen type  | page header text | number of questions | tblhead1 | tblhead2 | screen to get results from | tab name | screen to send results to"
	// questions = "question | feedback | number of follow questions"
	// followup = "question | feedback"
	
	var screencount=2; // zero-based
	var pre_review_count = 1 // zero-based
	var body_screen = 9;
	var body_q = 1;
	var case_name = "opioids_5b";
	var txt_casehistory = "John, a 47 year-old man with diagnosed low back pain, is a patient at your practice. He has been calling your clinic daily for the last three days requesting an early release of his opioids as he has run out early.  This is the third time he has run out early in the last 5 months. His last message was aggressive and he is demanding to see you as he feels it is your fault he is going into withdrawal and you are unethically not providing him with any means for pain control.";
	var img_caseicon = "ImgCaseStudy-John_thm.jpg";
	var wleft = ((document.width/2)-250);
	var wtop = ((document.height/2)-140);
	var mf = "female";
	var videoIcon = "<img src='video.png' width='20' align='left' class='videoIcon'>";
	
	var case_screen = [
	
   	{ val: "0|Step 1 of 3: Patient unacceptable behaviour|<br><p class='indentLR'>John, a 47 year-old man with diagnosed low back pain, is a patient at your practice. He has been calling your clinic daily for the last three days requesting an early release of his opioids as he has run out early.  This is the third time he has run out early in the last 5 months. His last message was aggressive and he is demanding to see you as he feels it is your fault he is going into withdrawal and you are unethically not providing him with any means for pain control.  </p><br><p class='indentLR'>Care  providers are strongly advised to acquaint themselves with applicable  legislation and their provincial regulatory body&rsquo;s policies/guidelines  regarding standards and termination of the physician-patient relationship. It  is important to know the obligations to the patient, staff, and society if  illegal patient activities are suspected.</p><br><p class='indentLR'>How do you respond...</p><br><br><p class='indentLR eg' style='font-weight:bold;'>Click on the appropriate checkbox to view suggested strategies for the situations outlined. Once you have finished, click the <em>Next Step</em> button at the bottom of the clipboard to continue. </p>|3|If John...|Suggested Strategy|0|Patient unacceptable behaviour|0", questions: [
        { val: "&hellip; aggressively  demands a higher opioid dose.|Aberrant drug-related behaviours that stem from opioid addiction, such as aggressively demanding higher opioid doses or double-doctoring, often resolve when the care provider  ceases prescribing and refers the patient to addiction treatment. If the patient refuses to accept treatment referral and continues to demand opioids, the care provider may consider discharging the patient from the practice.|0", followup: [] },
        { val: "&hellip; alters his prescription.|<p>Altering  prescriptions is fraud.&nbsp; If a patient  presents a fraudulent prescription to the pharmacist, the pharmacist must  report. If the patient returns with a fraudulent prescription to the MD and the  MD recognizes it as such, a call to CMPA and probably the police is in  order.&nbsp; This is criminal activity and not  a counselling situation.</p>It  is important to know the obligations to the patient, staff, and society if  illegal patient activities are suspected.|0", followup: [] },
        { val: "&hellip; threatens violence or commits actual violence.|<p>The care provider could contact the police if the patient has,  for example:</p><ul>  <li>threatened violence and there is perceived  danger</li>  <li>committed violence against clinic staff and  other patients, or</li>  <li>vandalized or stolen property.</li></ul>|0", followup: [] }
   	] },
	
   { val: "0|Step 2 of 3: Feedback|<br><p class='indentLR'>There are a number of strategies that might help you mitigate patient disagreement with opioid prescriptions or unacceptable behaviour. Some  of these strategies include:</p>|5|Response|Feedback|0|Feedback|0", questions: [
        { val: "Develop a treatment agreement as soon as the patient has been on ANY opioids for over 3 months OR sooner if you start with long acting preparations. |It is important that the therapeutic agreement and treatment goals are reviewed with the patient. If this was not previously done this is an excellent time to review the expectations and responsibilities of the patient and safe use of opioids. Also emphasize the right of the physician to stop prescribing should the therapeutic contract be broken or unacceptable behaviour demonstrated. |0", followup: [] },
        { val: "Provide explanations for changes in prescribing.|<p>Demonstrate:</p><ul>  <li>The prescribing is consistent with existing guidelines.</li><li>The  change is intended to help, not penalize, the patients, e.g., it is meant to  reduce the pain and improve mood, activity, and safety.</li></ul>|0", followup: [] },
        { val: "Book a longer appointment to allow for more time to provide education and explanations.|Meeting, educating and counselling patients who are self-medicating or showing aberrant and unacceptable behaviours often takes longer than a standard appointment. Be sure for care provider safety that, if all possible, the encounter does not take place after hours or when alone in clinic. |0", followup: [] },
        { val: "Arrange for a consultation.|Patients may accept a &ldquo;team decision&rdquo; more  readily than an individual one.|0", followup: [] },
        { val: "Document verbal agreements and past discussions.|Documenting agreed upon approaches can help identify aberrant behaviour. |0", followup: [] }
   	] },
	
   	{ val: "2|Step 3 of 3: REVIEW|<p class='indentLR'>Suggested review of the case pertaining to Management of John. During this case, you have made several choices. The choices you have made are indicated by an arrow.</p><br>|1|||0||0", questions: [
        { val: "" }
   	] }

	];