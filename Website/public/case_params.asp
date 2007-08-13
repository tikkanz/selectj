<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/default_usercase.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta content="Ric Sherlock" name="author" />
<!-- InstanceBeginEditable name="pgtitle" -->
<title>AnimalSim</title>
<!-- InstanceEndEditable -->
<script language="JavaScript" src="interface.js" type="text/javascript">
</script>
<link rel="stylesheet" href="animalsim.css" type="text/css" />
<!-- InstanceBeginEditable name="stylesheets" --><link rel="stylesheet" href="forms.css" type="text/css" /><!-- InstanceEndEditable -->
<!-- InstanceParam name="bodyOnload" type="text" value="" -->
</head>
<body onload="">
<div id="masthead">
  <div id="logo"><a href="default.jhp"><img src="img/deltag.png" alt="AnimalSim home" width="91" height="55" border="0" /></a></div> 
  <h1 id="siteName">AnimalSim  - <span class="small"><%=pp_fname%> <%=pp_lname%> logged in</span></h1> 
  <div id="globalNav"> 
  	<a href="http://www.massey.ac.nz" target="_blank">Massey University </a> | <a href="http://ivabs.massey.ac.nz" target="_blank">IVABS</a> | <a href="http://webct-ce.massey.ac.nz/webct/homearea/homearea?" target="_blank">Massey WebCT courses</a> | <a href="http://animalsim.massey.ac.nz/" target="_blank">AnimalSim website</a>
  </div> 
</div> 
<!-- end masthead --><div id="breadCrumb"><!-- InstanceBeginEditable name="breadCrumb" --><a href="default.jhp?action=logout">Logout</a> &gt; <a href="user.jhp?action=home">myCourses</a> &gt; <a href="course.jhp?action=home">CourseHome</a> &gt; <a href="case.jhp?action=home">CaseHome</a> &gt; <span class="current">Selection Details</span><!-- InstanceEndEditable --></div>
<div class="courseName"><!-- InstanceBeginEditable name="courseName" --><%= cr_code%> - <%= cr_name %><!-- InstanceEndEditable --></div>
<div id="content">
  <!-- InstanceBeginEditable name="pgContent" -->
  <h2 id="pageName"><%= sd_name %> </h2>
  <div class="story">
     <h3><%= xn_name %> </h3>
      <p><%=cx_text%> </p>
    <div class="form-container">
      <form action="" method="post" enctype="multipart/form-data" name="params" id="params">
        <p class="legend">This is the legend for my form</p>
          <fieldset>
            <legend>Progress</legend>
            <div>
                <label for="nCycles">No. years to select for</label>
                <input name="nCycles" type="text" disabled="disabled" id="nCycles" size="4" maxlength="3"/>            
            </div>
            <div>
                <label for="currCycle">Current year of selection</label>
                <input name="currCycle" type="text" disabled="disabled" id="currCycle" size="4" maxlength="3"/>            
            </div>
        </fieldset>
          <fieldset>
          	<legend>Population Size</legend>
            <label for="FlkSizes">No. of Breeding Females</label>
            <select id="FlkSizes" name="FlkSizes">
            	<option value="100">100</option>
            	<option value="200" selected="selected">200</option>
            	<option value="300">300</option>
            	<option value="400">400</option>
            	<option value="500">500</option>
            	<option value="750">750</option>
            	<option value="1000">1000</option>
            	<option value="1500">1500</option>
            	<option value="2000">2000</option>
            	<option value="4000">4000</option>
            </select>
            <p class="note">Replacement females that are too young to breed, are not included in this figure.<br />&nbsp;</p>
        </fieldset>
        <fieldset>
            <legend>Selection Strategy </legend>
            <label for="Trts2Select">Traits to Select for</label>
<select multiple="multiple" size="7" name="Trts2Select" id="Trts2Select">
            	<option value="NLB">(NLB) Number of Lambs Born</option>
            	<option value="LW8" selected="selected">(LW8) Live weight at 8-mon</option>
            	<option value="FW12">(FW12) Fleece weight at 12-mon</option>
				<option value="FD">(FD) Ultrasound back fat depth</option>
                <option value="FAT">(FAT) Carcass Fat content</option>
                <option value="LEAN">(LEAN) Carcass Lean content</option>
        </select>
        </fieldset>
		  <div class="buttonrow">
		  	<input type="submit" class="button" value="Save Changes" onclick="formSubmit()"/>
 			<input type="button" class="button" value="Discard Changes"/>
		  </div>          
      </form>
    </div>
  </div>
<!-- InstanceEndEditable --></div> 
<!--end content --><div id="navBar"> 
  <div id="sectionLinks"> 

    <dl> 
      <dt>Case Menu</dt>
      <!--<dd><a href="../poplntype.asp">Choose Question </a></dd>
	  <dd><a href="../usrhome.asp">Home page </a></dd> --> 
      <dd><a href="case.jhp?action=status">Case status</a></dd>
	  <dd><a href="case.jhp?action=params">Selection details</a></dd> 
      <dd><a href="case.jhp?action=selectmate">Breed your flock</a></dd> 
      <dd><a href="case.jhp?action=reset">Reset case</a></dd>
      <!--<dd><a href="../default.jhp?action=logout">Logout </a></dd>--> 
    </dl>&nbsp;
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
