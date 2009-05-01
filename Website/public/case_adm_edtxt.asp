<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/default_usercase.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta content="Ric Sherlock" name="author" />
<!-- InstanceBeginEditable name="pgtitle" -->
<title>AnimalSim Live</title>
<!-- InstanceEndEditable -->
<script language="JavaScript" src="interface.js" type="text/javascript">
</script>
<link rel="stylesheet" href="animalsim.css" type="text/css" />
<!-- InstanceBeginEditable name="stylesheets" --><link rel="stylesheet" href="forms.css" type="text/css" /><!-- InstanceEndEditable -->
<!-- InstanceParam name="bodyOnload" type="text" value="REVStatus()" -->
</head>
<body onload="REVStatus()">
<div id="masthead">
  <div id="logo"><a href="default.jhp"><img src="img/deltag.png" alt="AnimalSim home" width="91" height="55" border="0" /></a></div> 
  <h1 id="siteName">AnimalSim Live - <span class="small"><%=pp_fname%> <%=pp_lname%> logged in</span></h1> 
  <div id="globalNav"> 
  	<a href="http://www.massey.ac.nz" target="_blank">Massey University </a> | <a href="http://ivabs.massey.ac.nz" target="_blank">IVABS</a> | <a href="http://webct-ce.massey.ac.nz/webct/homearea/homearea?" target="_blank">Massey WebCT courses</a> | <a href="http://animalsim.massey.ac.nz/" target="_blank">AnimalSim website</a>
  </div> 
</div> 
<!-- end masthead --><div id="breadCrumb"><!-- InstanceBeginEditable name="breadCrumb" --><a href="default.jhp?action=logout">Logout</a> &gt; <a href="user.jhp?action=home">myCourses</a> &gt; <a href="course.jhp?action=home">CourseHome</a> &gt; <a href="case.jhp?action=home">CaseHome</a> &gt; <span class="current">Selection Details</span><!-- InstanceEndEditable --></div>
<div class="courseName"><!-- InstanceBeginEditable name="courseName" --><%= cr_code%> - <%= cr_name %><!-- InstanceEndEditable --></div>
<div id="content">
  <!-- InstanceBeginEditable name="pgContent" -->
  <div id="caseInfo">
  <div id="caseName"><h2><%= sd_name %> <span class="objcode" title="ID number for your case">(<%=cinstid%>)</span> <span class="subhead"><%=ci_usrname%></span></h2>
    <p><%= sd_descr %> </p>
  </div>
  </div>
  <div class="story">
     <h3>Edit Case Text</h3>
      <p>Create or edit the appropriate text for each stage of a case. </p>
      <p>Type or edit the text (HTML formatting is allowed) you wish to appear for the selected case stage in the text box below. </p>
    <div class="form-container"><form id="edittext" name="edittext" method="post" action="case.jhp"><input class="input" type="hidden" name="action" id="action" value="chgcxtext" />
<fieldset><legend>Case Text</legend>
<div>
  <label for="cx_xnid">Text for: </label>
  <select name="cx_xnid" id="cx_xnid" onchange="get the new text to populate the textarea below">
    <option value="1" >Introduction</option>
    <option value="11">Instructions</option>
    <option value="21">Between Cycles</option>
    <option value="99" selected="selected">Conclusion</option>
    </select>
</div>
<div>
  <label for="cx_text">Text to edit</label>
<textarea name="cx_text" id="cx_text" cols="55" rows="5"><%=cx_text%></textarea>
</div>
</fieldset>
<div class="buttonrow"><input class="button" type="submit" value="Save Changes" />
<input class="button" type="reset" value="Discard Changes" /></div></form></div>
  </div>      
  </div>
<!-- InstanceEndEditable --></div> 
<!--end content --><div id="navBar"> 
  <div id="userMenu"> 
    <dl> 
      <dt>Case Menu</dt>
      <dd><a href="case.jhp?action=home" title="Return to case home (make no changes)">CaseHome</a></dd>
	  <dd><a href="case.jhp?action=usrdescr" title="Give this case its own name and description">Describe case</a></dd> 
	  <dd><a href="case.jhp?action=params" title="View and/or change current case settings">Selection details</a></dd> 
      <dd><a href="case.jhp?action=breed" title="Breed your population using current settings">Breed  population</a></dd> 
      <dd><a href="case.jhp?action=reset&store=false" title="Discard current case and start a new one" onClick="return resetCase(<%= cistage %>,<%= cistored %>)">Reset case</a></dd>
      <dd style="display:<%=(cistage=99){::'none';'block'%>"> <a href="<%= cistored{::'case.jhp?action=store" title="Save completed case so you can analyse it later">Save completed case';'coursesumry.jhp">Analyse saved case' %></a></dd> 
    </dl>&nbsp;
    </div>
    <div id="adminMenu" style="display:<%=(offrole>1){::'none';'block'%>"> 
    <dl> 
      <dt>Admin Menu</dt>
      <dd><a href="case_adm.jhp?action=edittext" title="Edit or replace page text">Edit text</a></dd>
	  <dd><a href="case_adm.jhp?action=usrdescr" title="Give this case its own name and description">Save as new case</a></dd> 
	  <dd><a href="case_adm.jhp?action=params" title="View and/or change current case settings">Selection details</a></dd> 
      <dd><a href="case_adm.jhp?action=manage" title="Manage cases">Manage cases</a></dd> 
    </dl>&nbsp;
  </div> 
</div>
<!--end navbar --> 
<div id="siteInfo"> 
  <img src="img/fill_clear.gif" alt="fill gif" width="1" height="1"/> <a href="mailto:R.G.Sherlock@massey.ac.nz">Contact Me</a> | &copy;2005-2008
  Ric Sherlock
</div> 
<br/> 
</body>
<!-- InstanceEnd --></html>
