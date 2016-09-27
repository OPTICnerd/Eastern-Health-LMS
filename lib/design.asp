<%

function siteHeader(pageType)
%>
<!DOCTYPE html>
<html lang="en">
<!--[if IE 9]>
<html class="ie9" lang="en">    <![endif]-->
<!--[if IE 8]>
<html class="ie8" lang="en">    <![endif]-->
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name=viewport content="width=device-width, initial-scale=1">
   <title><%=SiteTitle%> | <%=SubSiteTitle%></title>
   <meta name="description" content="">
   <meta name="keywords" content="">
   <meta name="author" content="">

   <!-- CSS -->
   <link href="/assets/vendor/bootstrap/css/bootstrap.min.css"        property='stylesheet' rel="stylesheet" type="text/css" media="screen"/>
   <link href="/assets/vendor/fontawesome/css/font-awesome.min.css"   property='stylesheet' rel="stylesheet" type="text/css" media="screen"/>
   <link href="/assets/vendor/flaticons/flaticon.css"                 property='stylesheet' rel="stylesheet" type="text/css" media="screen"/>
   <link href="/assets/vendor/hover/css/hover-min.css"                property='stylesheet' rel="stylesheet" type="text/css" media="screen"/>
   <link href="/assets/vendor/wow/animate.css"                        property='stylesheet' rel="stylesheet" type="text/css" media="screen"/>
   <link href="/assets/vendor/mfp/css/magnific-popup.css"             property='stylesheet' rel="stylesheet" type="text/css" media="screen"/>
   <link href="/assets/vendor/sky-forms/sky-forms.css" 				  property='stylesheet' rel="stylesheet" type="text/css" media="screen"/>
   <link href="/assets/vendor/redactor/redactor.min.css"			  property='stylesheet' rel="stylesheet" type="text/css" media="screen"/>
   <!-- Custom styles -->
   <link href="/assets/custom/css/style.css"                          property='stylesheet' rel="stylesheet" type="text/css" media="screen"/>

   <style>
      #preloader {
         position: fixed;
         left: 0;
         top: 0;
         z-index: 99999;
         width: 100%;
         height: 100%;
         overflow: visible;
         background: #666666 url("/assets/custom/images/preloader.gif") no-repeat center center; }
   </style>

</head>
<!-- Preloader 
<div id="preloader">
    <div id="status">&nbsp;</div>
</div>-->

<body class="boxed">

<!--Pre-Loader
<div id="preloader"></div>-->

<header>

   <section id="top-navigation" class="container-fluid nopadding">

      <div class="row nopadding ident e-bg-light-texture">

         <!-- Site Logo -->
         <a href="#!">
            <div class="col-md-5 col-lg-4 vc-photo">&nbsp;</div>
         </a>
         <!-- /Site Logo -->

         <div class="col-md-7 col-lg-8 site-name nopadding">
            <!-- Name-Position -->
            <div class="row nopadding name">
               <div class="col-md-12 name-title"><h2 class="font-accident-two-light uppercase"><%=SiteTitle%></h2></div>
              
            </div>
            <div class="row nopadding site-subname">
               <div class="col-md-12 sub-title">

                  <section class="cd-intro">
                     <h4 class="cd-headline clip is-full-width font-accident-two-normal uppercase">
                        <span>Leadership Management Training</span>
                        
                     </h4>
                  </section>

               </div>
               <!-- <div class="col-md-2 nopadding pdf">
                  <a href="#" class="hvr-sweep-to-right"><i class="flaticon-behance7" title="My Behance Portfolio"></i></a>
               </div>-->
            </div>
            <!-- /Name-Position -->

           <!-- Main Navigation -->

           <% 
		   select case pageType
			  case "admin"
				  call AdminMenu
			  
			  case else
				  call SiteMenu
		  end select

		   %>

            <!-- /Main Navigation -->

         </div>
      </div>
   </section>

</header>
<!-- Container -->
<div class="content-wrap">
       
      <%
	  if session("UserMessage") <> "" then
	  	echo("<br clear=""all""/>")
	  	echo(session("UserMessage"))
	  end if
	
end function

function SiteMenu
%>
 <ul id="nav" class="row nopadding cd-side-navigation">
   <li class="col-xs-4 col-sm-2 nopadding menuitem green">
      <a href="index.html" class="hvr-sweep-to-bottom"><i class="flaticon-home"></i><span>home</span></a>
   </li>
   <% 'if isLoggedIn = True  then %>
   <li class="col-xs-4 col-sm-2 nopadding menuitem blue">
      <a href="resume.html" class="hvr-sweep-to-bottom"><i class="flaticon-calendar"></i><span>Schedule</span></a>
   </li>
   <li class="col-xs-4 col-sm-2 nopadding menuitem cyan">
     <a href="portfolio.html" class="hvr-sweep-to-bottom"><i class="flaticon-speech-bubble"></i><span>Discussions</span></a>
   </li>
   <li class="col-xs-4 col-sm-2 nopadding menuitem orange">
      <a href="contacts.html" class="hvr-sweep-to-bottom"><i class="flaticon-agenda"></i><span>Resources</span></a>
   </li>
   <li class="col-xs-4 col-sm-2 nopadding menuitem red">
      <a href="feedback.html" class="hvr-sweep-to-bottom"><i class="flaticon-share-1"></i><span>Feedback</span></a>
   </li>
   
      <!--blog</span></a>-->
	
   <%
   	'end if
   
	if session("AccountType") = 3 then ' user is an admin
		echo("<li class=""col-xs-4 col-sm-2 nopadding menuitem yellow""><a href=""/admin/"" class=""hvr-sweep-to-bottom""><i class=""flaticon-tool-1""></i><span>Administration</span></a></li>")
	else
		echo("<li class=""col-xs-4 col-sm-2 nopadding menuitem yellow""><a href=""/admin/"" class=""hvr-sweep-to-bottom""><i class=""flaticon-tool""></i><span>Log Out</span></a></li>")
		
		
	end if
	%>
</ul>

<%
end function


function AdminMenu
%>
<nav class="navbar navbar-default navbar-header-full navbar-dark navbar-static-top" role="navigation" id="header">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <i class="fa fa-bars"></i>
            </button>
            <a id="ar-brand" class="navbar-brand hidden-lg hidden-md hidden-sm" href="/">Eastern Health</a>
        </div> <!-- navbar-header -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
	
    <%
	if session("AccountType") = 3 then ' user is an admin
		echo("<li><a href=""/admin/"">Dashboard</a></li>")
		echo("<li><a href=""/admin/?aid=1"">Users</a></li>")
		echo("<li><a href=""/admin/?aid=2"">Courses</a></li>")
		echo("<li><a href=""/admin/?aid=3"">Cohorts</a></li>")
		echo("<li><a href=""/admin/?aid=4"">Resources</a></li>")
	end if
	%>
</ul>



        </div><!-- navbar-collapse -->

        

    </div><!-- container -->

</nav>

<%

end function


function siteFooter(pageType)

%>
<footer class="padding-50 e-bg-light-texture">
   <div class="container-fluid nopadding">
      <div class="row wow fadeInDown" data-wow-delay=".2s" data-wow-offset="10">
         <div class="col-md-9">
            <h4 class="font-accident-two-bold uppercase">About The Program</h4>
            <p class="inline-block">
               skjvfhks hvkjdhfvkd vhdkv kfvh j
            </p>
            <div class="divider-dynamic"></div>
         </div>
        
         <div class="col-md-3">
            <h4 class="font-accident-two-bold uppercase">Other Footer Items</h4>


            <div class="divider-dynamic"></div>
         </div>
      </div>
      <div class="dividewhite1"></div>
      <div class="row wow fadeInDown" data-wow-delay=".4s" data-wow-offset="10">
         <div class="col-md-12 copyrights">
            <p>© 2016 Office of Professional Development (OPD).</p>
         </div>
      </div>
   </div>
</footer>

<div id="image-cache" class="hidden"></div>

<!-- JS -->
<script src="/assets/vendor/jquery/js/jquery-2.2.0.min.js"            type="text/javascript"></script>
<script src="/assets/vendor/bootstrap/js/bootstrap.min.js"            type="text/javascript"></script>
<script src="/assets/vendor/imagesloaded/js/imagesloaded.pkgd.min.js" type="text/javascript"></script>
<script src="/assets/vendor/isotope/js/isotope.pkgd.min.js"           type="text/javascript"></script>
<script src="/assets/vendor/mfp/js/jquery.magnific-popup.min.js"      type="text/javascript"></script>
<script src="/assets/vendor/circle-progress/circle-progress.js"       type="text/javascript"></script>
<script src="/assets/vendor/waypoints/waypoints.min.js"               type="text/javascript"></script>
<script src="/assets/vendor/anicounter/jquery.counterup.min.js"       type="text/javascript"></script>
<script src="/assets/vendor/wow/wow.min.js"                           type="text/javascript"></script>
<script src="/assets/vendor/pjax/jquery.pjax.js"                      type="text/javascript"></script>

<!-- Custom scripts -->
<script src="/assets/custom/js/custom.js"                             type="text/javascript"></script>

</body>

</html>
<%
session("UserMessage") = ""
end function


function showLogin
%>
<section id="homesection" class="container-fluid nopadding">
	<div class="m-details row nopadding skin">
    	<div class="col-md-6">
	
   <div class="padding-50 wow fadeIn" data-wow-delay="0.2s" data-wow-offset="10">
    <%
    if session("UserMessage") <> "" then
      echo(session("UserMessage"))
    end if
    %>
      <h3 class="font-accident-two-normal uppercase">Please Login</h3>

      <form action="/admin/" method="post" class="sky-form">


          <fieldset class="nomargin">

              <label class="input">
                  <i class="ico-append fa fa-user"></i>
                  <input required type="text" name="frmLogin" placeholder="Login">
              </label>

              <label class="input">
                  <i class="ico-append fa fa-lock"></i>
                  <input required type="password" name="frmPassword" placeholder="Password">
              </label>

          <div class="clearfix note margin-bottom-30">
              <!--<a class="pull-right" href="#">Forgot Password?</a>-->
          </div>

         

          </fieldset>
          <input type="hidden" name="frmAction" value="1">
          <footer>
              <button type="submit" class="btn btn-danger pull-right"> LOG IN</button>
          </footer>

      </form>

  
</div>

		</div>
        <div class="col-md-6">
			Right  
		</div>
 	</div>
</section>

<%
end function
%>