<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/default.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta content="Ric Sherlock" name="author" />
<!-- InstanceBeginEditable name="pgtitle" -->
<title>AnimalSim</title>
<!-- InstanceEndEditable -->
<script language="JavaScript" src="interface.js" type="text/javascript">
</script>
<link rel="stylesheet" href="2col_leftNav.css" type="text/css" />
<!-- InstanceParam name="JavascriptInHeader" type="boolean" value="false" -->
<!-- InstanceParam name="bodyOnload" type="text" value="" -->

</head>
<body onload="">
<div id="masthead">
  <div id="logo"><a href="default.jhp"><img src="img/deltag2.png" alt="AnimalSim Home" width="91" height="55" border="0" /></a></div> 
  <h1 id="siteName">AnimalSim - <span class="small"><%= fname %> <%= lname %> logged in</span></h1> 
  <div id="globalNav"> 
  <a href="http://www.massey.ac.nz" target="_blank">Massey University </a> | <a href="http://ivabs.massey.ac.nz" target="_blank">IVABS</a> | <a href="http://webct.massey.ac.nz" target="_blank">Massey WebCT courses</a> | <a href="http://animalsim.massey.ac.nz/" target="_blank">AnimalSim website</a></div> 
</div> 
<!-- end masthead --> 
<div id="content"> 
  <!-- InstanceBeginEditable name="pgContent" -->
  <h2 id="pageName">Population Home </h2>
  <div class="story">
    <h3>Hi there! </h3>
    <p>You are currently logged in as <%= fname %> <%= lname %>.  If that is not correct, <a href="default.jhp?action=logout">log out</a> and login again using your username and password.</p>
    <p>Your current population is: <em><%= PoplnDescrip %></em>. <br />
    So far it has undergone <%= 0 >. CurrYear %> cycles of selection.</p>
    <p>What do you want to do next? Choose a task from the list on the left.</p>
  </div>
<!-- InstanceEndEditable --></div> 
<!--end content --> 
<div id="navBar"> 
  <div id="sectionLinks"> 
    <ul> 
      <li><a href="poplntype.asp">Choose Question </a></li>
	  <!-- <li><a href="../usrhome.asp">Home page </a></li>  
      <li><a href="../resetpopln.asp">Reset your population </a></li> -->
	  <li><a href="viewpopparams.asp">Change Selection details</a></li> 
      <li><a href="selectmate.asp">Breed your flock</a></li> 
      <li><a href="default.jhp?action=logout">Logout </a></li> 
    </ul> 
  </div> 
  <div id="headlines"> 
  </div> 
</div> 
<!--end navbar --> 
<div id="siteInfo"> 
  <img src="img/fill_clear.gif" width="1" height="1"/> <a href="mailto:R.G.Sherlock@massey.ac.nz">Contact Me</a> | &copy;2005-2006
  Ric Sherlock
</div> 
<br/> 
</body>
<!-- InstanceEnd --></html>
