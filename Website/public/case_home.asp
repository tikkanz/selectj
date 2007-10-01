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
<!-- InstanceBeginEditable name="stylesheets" --><!-- InstanceEndEditable -->
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
<!-- end masthead --><div id="breadCrumb"><!-- InstanceBeginEditable name="breadCrumb" --><a href="default.jhp?action=logout">Logout</a> &gt; <a href="user.jhp?action=home">myCourses</a> &gt; <a href="course.jhp?action=home">CourseHome</a> &gt; <span class="current">CaseHome</span><!-- InstanceEndEditable --></div>
<div class="courseName"><!-- InstanceBeginEditable name="courseName" --><%= cr_code%> - <%= cr_name %><!-- InstanceEndEditable --></div>
<div id="content">
  <!-- InstanceBeginEditable name="pgContent" -->
  <div id="caseInfo">
  <div id="caseName"><h2><%= sd_name %> </h2>
    <p><%= sd_descr %> </p>
  </div>
  <div id="caseMsg">
    <p class="info" style="display:<%=(action-:'chgdparams'){::'none';'block'%>">Your Selection details were successfully changed. </p>
    <p class="info" style="display:<%=(action-:'resetfin'){::'none';'block'%>">The case was successfully reset. </p>
    <p class="info" style="display:<%=(action-:'cyclefin'){::'none';'block'%>">The selection cycle(s) completed successfully </p>    
    <p class="error" style="display:<%=('err'-: _3{.action){::'none';'block'%>"><%=errormsg %></p>
  </div>
  <div id="caseStatus">
    <p style="display:<%=(cistage=1){::'none';'block'%>">You have not yet started selecting your population. </p>
    <p style="display:<%=(cistage=21){::'none';'block'%>">Your population is beginning cycle <%=currcycle %> of <%=ncycles %> cycles of selection. </p>
    <p style="display:<%=(cistage=99){::'none';'block'%>">All your selection cycles are complete. </p>
  </div>
  </div>
  <div class="story">
    <h3><%=xn_name%> </h3>
    <p><%=cx_text%> </p>

    <p>What do you want to do next? Choose a task from the menu on the right. </p>
    <div id="SelListDwn" style="display:<%=('Between Cycles'-:,xn_name){::'none';'block'%>">
      <fieldset>
        <legend>Download selection lists </legend>
  		<form action="case.jhp" method="post" name="DwnldSL" id="DwnldFSL">
           <input type="hidden" id="action" name="action" value="download"/>
           <input type="hidden" id="filepath" name="filepath" value="Output/SelectLstFEM.csv"/>
           <input type="hidden" id="filename" name="filename" value="SelectLstFEM.csv"/>
           <input type="submit" id="dwnldfsl" value="Potential dams" />
  		</form>
  		<form action="case.jhp" method="post" name="DwnldSL" id="DwnldMSL">
           <input type="hidden" id="action" name="action" value="download"/>
           <input type="hidden" id="filepath" name="filepath" value="Output/SelectLstMALE.csv"/>
           <input type="hidden" id="filename" name="filename" value="SelectLstMALE.csv"/>
           <input type="submit" id="dwnldmsl" value="Potential sires" />
  		</form>
      </fieldset>
    </div>
    <div id="SelListUp" style="display:<%=('Between Cycles'-:,xn_name){::'none';'block'%>">
      <fieldset> <legend> Upload .csv files of Selected parents </legend>
      <form action="case.jhp" method="post" enctype="multipart/form-data" name="UpldSL" id="UpldSL">
          <input name="action" type="hidden" id="action" value="uploadSL" />
          <label for="Upld_fem">Selected dams </label>
          <input name="Upld_fem" type="file" id="Upld_fem" size="35"/>
          <label for="Upld_male">Selected sires  </label>
          <input name="Upld_male" type="file" id="Upld_male" size="35" />
          <input type="button" id="upld" onclick="upldSelctdList()" value="Upload Files &amp; Breed" />
      </form>
      </fieldset>
    </div>
    <div id="casesumry" style="display:<%=('Conclusion'-:,xn_name){::'none';'block'%>">
  		<form action="case.jhp" method="post" name="DwnldSumry" id="DwnldSumry">
                <fieldset>
                <legend>Download detailed population summary </legend>
                <input type="hidden" id="action" name="action" value="download"/>
                <input type="hidden" id="filepath" name="filepath" value="Output/AnimSummary.csv"/>
                <input type="hidden" id="filename" name="filename" value="Summary.csv"/>
                <input type="submit" id="dwnldsmry" value="Population Summary" />
                </fieldset>
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
      <dd><a href="case.jhp?action=breed">Breed  Population</a></dd> 
      <dd><a href="case.jhp?action=reset">Reset case</a></dd>
      <!--<dd><a href="../default.jhp?action=logout">Logout </a></dd>--> 
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
