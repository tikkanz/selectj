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
<!-- InstanceParam name="JavascriptInHeader" type="boolean" value="true" -->
<!-- InstanceParam name="bodyOnload" type="text" value="myformInit(objnmes,inivars)" -->
<!-- InstanceBeginEditable name="headJavaScript" -->
	<script type="text/javascript">
	//APL writes javascript to initalise variables for each named form element?
  		  var objnmes=new Array(<%=RS("objnames")%>)	//var objnmes=new Array("SelnMeth","SummType","Trts2Recrd","Trts2Select","Trts2Summ","MateAge","CullAge")
		  var inivars=new Array(<%=RS("inivars")%>)		//var inivars=new Array(new Array("genD"),new Array("phen","genDe"),new Array("NLB","FW12","FD"),new Array("NLB","LW8","FAT","LEAN"),new Array("NLB","FW12","FAT","LEAN"),new Array("2","3"),new Array("8","9"))
	</script>
<!-- InstanceEndEditable -->
</head>
<body onload="myformInit(objnmes,inivars)">
<div id="masthead">
  <div id="logo"><a href="default.jhp"><img src="img/deltag2.png" alt="AnimalSim Home" width="91" height="55" border="0" /></a></div> 
  <h1 id="siteName">AnimalSim - <span class="small"><%= fname %> <%= lname %> logged in</span></h1> 
  <div id="globalNav"> 
  <a href="http://www.massey.ac.nz" target="_blank">Massey University </a> | <a href="http://ivabs.massey.ac.nz" target="_blank">IVABS</a> | <a href="http://webct.massey.ac.nz" target="_blank">Massey WebCT courses</a> | <a href="http://animalsim.massey.ac.nz/" target="_blank">AnimalSim website</a></div> 
</div> 
<!-- end masthead --> 
<div id="content"> 
  <!-- InstanceBeginEditable name="pgContent" -->
  <h2 id="pageName">What Question would you like to answer? </h2>
  <form action="poplntype_chg.asp" method="post" name="PopTypeChoose" id="PopTypeChoose">
    <table class="frmtble">
	<tr><td>
		<label><input name="PoplnFnme" id="PoplnFnme" type="radio" value="BiggerPopln" />Can you make faster genetic progress with a bigger flock?</label><br /><br />
		<!-- <label><input name="PoplnFnme" id="PoplnFnme" type="radio" value="MateHoggets" />Will mating hoggets improve your genetics faster? Will production change too? </label><br /><br /> -->
		<label><input name="PoplnFnme" id="PoplnFnme" type="radio" value="EBVsBetter" />
		How much better is selection on Breeding Values (BVs/EBVs) than on raw measurements?<br />
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Does it work better for some traits than others?</label>
		<br />
		<br />		
    	<label><input name="PoplnFnme" id="PoplnFnme" type="radio" value="ChangeREVs" />Explore the effects of changing selection pressure on traits?</label><br /><br />  
		<label><input name="PoplnFnme" id="PoplnFnme" type="radio" value="GeneticCorr" />What other traits will change when I select for trait X?</label><br /><br />
		<label><input name="PoplnFnme" id="PoplnFnme" type="radio" value="AnswerOwn" />Answer your own questions.</label><br /><br />
		<label><input name="PoplnFnme" id="PoplnFnme" type="radio" value="SelectManual" />Choose your replacements individually.</label><br /><br />		
		<label><input name="PoplnFnme" id="PoplnFnme" type="radio" value="MajorGene" />Effect on selection where there is a major gene for live weight</label><br /><br />
	</td></tr>
	<tr><td>
		<input type="submit" id="chgetype" value="Select Question" />
	</td></tr>
	</table>
    </form>
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
