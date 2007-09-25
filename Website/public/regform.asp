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
<link rel="stylesheet" href="animalsim.css" type="text/css" />
<!-- InstanceBeginEditable name="stylesheets" -->
<!-- InstanceEndEditable -->
<!-- InstanceParam name="bodyOnload" type="text" value="" -->
</head>
<body onload="">
<div id="masthead">
  <div id="logo"><a href="default.jhp"><img src="img/deltag.png" alt="AnimalSim home" width="91" height="55" border="0" /></a></div> 
  <h1 id="siteName"><!-- InstanceBeginEditable name="SiteName" -->AnimalSim<!-- InstanceEndEditable --></h1> 
  <div id="globalNav"> 
  	<a href="http://www.massey.ac.nz" target="_blank">Massey University </a> | <a href="http://ivabs.massey.ac.nz" target="_blank">IVABS</a> | <a href="http://webct-ce.massey.ac.nz/webct/homearea/homearea?" target="_blank">Massey WebCT courses</a> | <a href="http://animalsim.massey.ac.nz/" target="_blank">AnimalSim website</a>
  </div> 
</div> 
<!-- end masthead --><div id="breadCrumb"><!-- InstanceBeginEditable name="breadCrumb" --><a href="default.jhp">Login</a> &gt; <span class="current">Register </span><!-- InstanceEndEditable --> </div>
<div id="contentNoNav"> 
  <!-- InstanceBeginEditable name="pgContent" -->

<h2 id="pageName">Create AnimalSim user account </h2>
<div class="story">
	<p>Please complete the form below to create a new  AnimalSim user account.<br />
    If you  already have an account, please <a href="default.jhp" tabindex="9" >return to the login page</a>.</p>
	 <p class="valerr" style="display:inline"><%= usernameErr %></p>
  </div>
<form action="register.jhp" method="post" name="regform" id="regform">
<input name="action" type="hidden" value="newuser" />
  <table border="0" cellspacing="0" class="frmtble" style="width: 340px; height: 230px;">

    <caption>
     Create user account 
    </caption> <tbody>

      <tr>
        <th scope="col" >User Name </th>
        <td scope="col" ><span class="valerr" id="unameErr">Please enter a User name.
<br /></span>
          <input name="uname" type="text" class="box1" id="uname" tabindex="1" title="Choose unique User name" />
          <span class="required">*</span></td>
      </tr>
      <tr>

        <th scope="col" >First Name </th>

        <td scope="col" ><span class="valerr" id="fnameErr">Please enter your first name.<br />
        </span>
        <input name="fname" type="text" class="box1" id="fname" tabindex="2" value="<%= fname %>"/>
        <span class="required">*</span></td>

      </tr>

      <tr>

        <th scope="row">Last Name </th>

        <td><span class="valerr"  id="lnameErr">Please enter your last name.<br />
        </span>
		    <input id="lname" name="lname" class="box1" type="text" tabindex="3" value="<%= lname %>"/>
          <span class="required">*</span></td>

      </tr>

      <tr>

        <th scope="row">Student ID </th>

        <td><input name="refnum" class="box1" id="refnum" type="text" tabindex="4" value="<%= refnum %>"/></td>

      </tr>

      <tr>

        <th scope="row">Email Address </th>

        <td><span class="valerr" id="emailErr">Please enter your email address.<br />
        </span>
		  <input name="email" class="box1" id="email" type="text" tabindex="5" value="<%= email %>"/>
          <span class="required">*</span></td>

      </tr>

      <tr>
        <th scope="row">Password</th>
        <td><span class="valerr" id="passwdErr">Please enter a password.</span>
		<input name="passwd" class="box1" id="passwd" type="password" tabindex="6" />
          <span class="required">*</span></td>
      </tr>
      <tr>

        <th scope="row">Confirm<br /> 
          password</th>

        <td><span class="valerr" id="passwdcErr">Passwords do not match.<br />
         Re-enter passwords.</span>
		<input name="passwdc" class="box1" id="passwdc" type="password" tabindex="7" />
          <span class="required">*</span> </td>

      </tr>
      <tr>
        <th scope="row">&nbsp;</th>
        <td><input name="Button" type="button" id="submt" tabindex="8" onclick="javascript:callregsubmit();" value="Create account" /></td>
      </tr>

    </tbody>
  </table>

  <p style="text-align: center;">
  </p>

</form>

<!-- InstanceEndEditable --></div> 
<!--end content --><!-- InstanceBeginEditable name="navbar" --><!-- InstanceEndEditable --> 
<!--end navbar --> 
<div id="siteInfo"> 
  <img src="img/fill_clear.gif" alt="fill gif" width="1" height="1"/> <a href="mailto:R.G.Sherlock@massey.ac.nz">Contact Me</a> | &copy;2005-2008
  Ric Sherlock
</div> 
<br/> 
</body>
<!-- InstanceEnd --></html>
