	// screen = "screen type  | page header text | number of questions | tblhead1 | tblhead2 | screen to get results from | tab name | screen to send results to"
	// questions = "question | feedback | number of follow questions"
	// followup = "question | feedback"
	
	var screencount=2; // zero-based
	var pre_review_count = 1 // zero-based
	var body_screen = 9;
	var body_q = 1;
	var case_name = "opioids_5";
	var txt_casehistory = "<p>[ Case history for Trent ]</p>";
	var img_caseicon = "opiods-56-year-old-woman_thumb.png";
	var wleft = ((document.width/2)-250);
	var wtop = ((document.height/2)-140);
	var mf = "female";
	var videoIcon = "<img src='video.png' width='20' align='left' class='videoIcon'>";
	
	var case_screen = [
	
   	{ val: "0|Addiction Treatment Options|<br><p class='indentLR'>Has developed an addiction to XXX  which he was taking due to CNCP condition&hellip; Comes to you seeking strategies to  help him address his addiction. What strategies might you discuss  with Trent?</p><p class='indentLR note'>Need icon and case history for Trent</p>|4|Question|Feedback|0|Addiction Treatment Options|0", questions: [
        { val: "Methadone treatment.|<p>Indications for methadone treatment  are any of the following:</p><ul>  <li>a failed trial of structured  opioid therapy</li>  <li>using opioids by  injection, snorting, or crushing tablets</li>  <li>accessing opioids from  multiple physicians or from the &quot;street&quot;</li>  <li>addiction to opioids and  to other drugs/substances, e.g., alcohol, cocaine</li></ul><p>Methadone is effective for the treatment  of opioid addiction in the presence of CNCP.</p><ul>  <li>Methadone maintenance  treatment involves daily supervised dispensing, urine drug screening, and  counseling.</li>  <li>To obtain an exemption  to prescribe methadone for opioid addiction, physicians should check with their  provincial regulating body for direction.</li>  <li>The patient should be  expected to consent to open communication between the methadone provider and  the primary-care physician (include in treatment agreement).</li></ul>Primary-care physicians and methadone providers  should inform each other of newly diagnosed health conditions for the patient  and long-term prescribing of other medications, particularly opioids and  benzodiazepines.|0", followup: [] },
        { val: "Buprenorphine treatment.|<p>Indications for buprenorphine  treatment are similar to those for methadone treatment; buprenorphine treatment  could be preferred over methadone for:</p><ul>  <li>patients who are at  higher risk of methadone toxicity (e.g., elderly, benzodiazepine users)</li>  <li>adolescents and young  adults</li>  <li>patients in communities  where methadone treatment is unavailable.</li></ul><p>Buprenorphine is a safe and  effective treatment for patients with a dual diagnosis of CNCP and opioid  addiction.</p><ul>  <li>Physicians should be  aware of provincial regulatory guidelines regarding buprenorphine prescribing  and training requirements.</li></ul>Buprenorphine (buprenorphine and  buprenorphine-naloxone are being used interchangeably) is a partial mu opioid  agonist with a long duration of action. It is a well-established treatment,  with good supporting evidence for the treatment of opioid addiction (West 2000;  Mattick 2008).|0", followup: [] },
        { val: "Structured Opioid Therapy (SOT).|<p>Structured opioid therapy (SOT) has  been shown to improve outcomes in patients who have exhibited aberrant  drug-related behaviours. SOT is the use of opioids (other than methadone or buprenorphine)  to treat CNCP with specific controls in place, including patient education, a  written treatment agreement, agreed-on dispensing intervals, and frequent  monitoring.</p><p>Indications for a Structured Opioid  Therapy Trial</p><p>An ideal candidate for a SOT trial  would be an opioid-addicted patient with CNCP who: </p><ul>  <li>Has a well-defined  somatic or neuropathic pain condition for which opioids have been shown to be  effective. (See Recommendation 4 for a review of evidence of opioid  effectiveness.)</li>  <li>Is well-known to the  physician</li>  <li>Is not currently  addicted to cocaine, alcohol or other drugs</li>  <li>Is not, to the  physician&rsquo;s knowledge, accessing opioids from other sources, injecting or  crushing oral opioids, or diverting the opioid</li></ul><p>Treatment Agreement Specifications</p><p>A written treatment agreement is  strongly recommended. It should specify controls relating to prescribing and  monitoring, and outline expectations of patient compliance with referral for  consultation or treatment programs, e.g., pain management and/or addiction  consultation or programs.</p><p>Opioid Selection and Prescribing</p><p>1. Selection: It may be advisable to  switch patients to a different opioid. Avoid oxycodone and hydromorphone, if  possible.</p><p>&nbsp;2. Dose: It is advisable to keep below 200 mg  morphine equivalent.</p><p>&nbsp;3. Dispensing intervals: e.g., daily,  bi-weekly or weekly dispensing interval, with no early prescription refills.</p><p>Monitoring Structured Opioid Therapy</p><p>Frequent monitoring is required; it  could include:</p><ul>  <li>Urine drug screening</li>  <li>Pill and patch count </li>  <li>Evaluation for  significant opioid effectiveness (i.e., improved function or at least 30%  reduction in pain intensity)</li></ul><p>3.5 Failed Trial </p>If a) opioid effectiveness is not achieved, or  b) the patient is not compliant, consider the SOT a failed trial. Taper and refer  for opioid agonist treatment or abstinence-based treatment.|0", followup: [] },
        { val: "Abstinence-Based Treatment.|<p>Structured opioid therapy (SOT) has  been shown to improve outcomes in patients who have exhibited aberrant  drug-related behaviours. SOT is the use of opioids (other than methadone or buprenorphine)  to treat CNCP with specific controls in place, including patient education, a  written treatment agreement, agreed-on dispensing intervals, and frequent  monitoring.</p><p>Indications for a Structured Opioid  Therapy Trial</p><p>An ideal candidate for a SOT trial  would be an opioid-addicted patient with CNCP who: </p><ul>  <li>Has a well-defined  somatic or neuropathic pain condition for which opioids have been shown to be  effective. (See Recommendation 4 for a review of evidence of opioid  effectiveness.)</li>  <li>Is well-known to the  physician</li>  <li>Is not currently  addicted to cocaine, alcohol or other drugs</li>  <li>Is not, to the  physician&rsquo;s knowledge, accessing opioids from other sources, injecting or  crushing oral opioids, or diverting the opioid</li></ul><p>Treatment Agreement Specifications</p><p>A written treatment agreement is  strongly recommended. It should specify controls relating to prescribing and  monitoring, and outline expectations of patient compliance with referral for  consultation or treatment programs, e.g., pain management and/or addiction  consultation or programs.</p><p>Opioid Selection and Prescribing</p><p>1. Selection: It may be advisable to  switch patients to a different opioid. Avoid oxycodone and hydromorphone, if  possible.</p><p>&nbsp;2. Dose: It is advisable to keep below 200 mg  morphine equivalent.</p><p>&nbsp;3. Dispensing intervals: e.g., daily,  bi-weekly or weekly dispensing interval, with no early prescription refills.</p><p>Monitoring Structured Opioid Therapy</p><p>Frequent monitoring is required; it  could include:</p><ul>  <li>Urine drug screening</li>  <li>Pill and patch count </li>  <li>Evaluation for  significant opioid effectiveness (i.e., improved function or at least 30%  reduction in pain intensity)</li></ul><p>3.5 Failed Trial </p>If a) opioid effectiveness is not achieved, or  b) the patient is not compliant, consider the SOT a failed trial. Taper and refer  for opioid agonist treatment or abstinence-based treatment.|0", followup: [] }
   	] },
	
   { val: "0|Feedback|<br><p class='indentLR'>Given the details we&rsquo;ve built (or  are yet to build) on this case, is there anything we can say about a preferred  method here, or are all options equally viable for Trent&hellip;?</p>|1|||0|Feedback|0", questions: [{ val: "null||0", followup: [] }] },
	
   	{ val: "2|REVIEW|<p class='indentLR'>Suggested review of the case pertaining to Management of Sharon. During this case, you have made several choices. The choices you have made are indicated by an arrow.</p>|1|||0||0", questions: [
        { val: "" }
   	] }
	];