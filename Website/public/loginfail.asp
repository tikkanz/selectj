<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/default_static_login.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta content="Ric Sherlock" name="author" />
<!-- InstanceBeginEditable name="pgtitle" -->
<title>AnimalSim</title>
<!-- InstanceEndEditable -->
<script language="JavaScript" src="interface.js" type="text/javascript">
</script>
<link rel="stylesheet" href="2col_leftNav.css" type="text/css" />
<!-- InstanceBeginEditable name="stylesheets" -->
<!-- InstanceEndEditable -->



</head>
<body onload="">
<div id="masthead">
  <div id="logo"><a href="default.jhp"><img src="img/deltag.png" alt="AnimalSim home" width="91" height="55" border="0" /></a></div> 
  <h1 id="siteName"><!-- InstanceBeginEditable name="SiteName" -->AnimalSim<!-- InstanceEndEditable --></h1> 
  <div id="globalNav"> 
  	<a href="http://www.massey.ac.nz" target="_blank">Massey University </a> | <a href="http://ivabs.massey.ac.nz" target="_blank">IVABS</a> | <a href="http://webct-ce.massey.ac.nz/webct/homearea/homearea?" target="_blank">Massey WebCT courses</a> | <a href="http://animalsim.massey.ac.nz/" target="_blank">AnimalSim website</a>
  </div> 
</div> 
<!-- end masthead --> 

<div id="contentNoNav"> 
  
  <div id="breadCrumb"> </div>
  <h2 id="pageName"><!-- InstanceBeginEditable name="page name" -->Welcome to the AnimalSim web interface<!-- InstanceEndEditable --></h2>
  <div class="story">
    <!-- InstanceBeginEditable name="Story" -->
	  <p>Using AnimalSim you can <em>investigate genetic selection</em>. Create your own breeding population, experiment with different selection objectives and strategies.</p>
	  <p>The<em> first time</em> you visit the site you will need to <a href="register.jhp" tabindex="4">create a new user account</a>. This enables AnimalSim to keep track of your population between sessions.</p>
  	  <p>If already have you have a user account, you can log in below.</p>
	  <p style="color:red; font-weight:bold">Username and password do not match. The username you entered was &quot;<%= uname %>&quot;. </p>
	<!-- InstanceEndEditable -->
  </div>
	<form action="login.jhp" method="post" name="login" id="login">
	  <table width="423" border="0" cellspacing="0" class="frmtble" style="height:110px;">
		<caption>
	  Login
		</caption>
		<tbody>
		  <tr>
			<th width="107" scope="col">User name </th>
			<td width="150"><input name="usrname" type="text" class="box1" id="usrname" tabindex="1" /></td>
			<td width="160" rowspan="3" class="register"><p>Haven't got an account yet?</p>
		    <p><a href="register.jhp">Create a user account now</a> </p></td>
		  </tr>
		  <tr>
			<th scope="row">Password </th>
			<td><input name="passwd" type="password" class="box1" id="passwd" tabindex="2" /></td>
		  </tr>
		  <tr>
			<td style="text-align:center"><a href="#" style="display:none">I forgot my password</a></td>
		    <td style="text-align:center"><input type="submit" id="submit1" tabindex="3" value="Login" /></td>
	      </tr>
		</tbody>
	  </table>
	</form>
</div> 
<!--end content --> 
<!--end navbar --> 
<div id="siteInfo"> 
  <img src="img/fill_clear.gif" width="1" height="1"/> <a href="mailto:R.G.Sherlock@massey.ac.nz">Contact Me</a> | &copy;2005-2006
  Ric Sherlock
</div> 
<br/> 
</body>
<!-- InstanceEnd --></html>
