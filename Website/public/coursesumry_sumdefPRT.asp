<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- InstanceBegin template="/Templates/default_user.dwt" codeOutsideHTMLIsLocked="false" -->
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
</head>
<body onload="">
<div id="masthead">
  <div id="logo"><a href="default.jhp"><img src="img/deltag.png" alt="AnimalSim home" width="91" height="55" border="0" /></a></div>
  <h1 id="siteName">AnimalSim  - <span class="small"><%=pp_fname%> <%=pp_lname%> logged in</span></h1>
  <div id="globalNav"> <a href="http://www.massey.ac.nz" target="_blank">Massey University </a> | <a href="http://ivabs.massey.ac.nz" target="_blank">IVABS</a> | <a href="http://webct-ce.massey.ac.nz/webct/homearea/homearea?" target="_blank">Massey WebCT courses</a> | <a href="http://animalsim.massey.ac.nz/" target="_blank">AnimalSim website</a> </div>
</div>
<!-- end masthead -->
<div id="breadCrumb"><!-- InstanceBeginEditable name="breadCrumb" --><a href="default.jhp?action=logout">Logout</a> &gt; <a href="user.jhp?action=home">myCourses</a> &gt; <a href="course.jhp?action=home">CourseHome</a> &gt; <span class="current">Course Summaries</span><!-- InstanceEndEditable --> </div>
<div id="contentNoNav"> <!-- InstanceBeginEditable name="pgContent" -->
  <h2 id="pageName"><%=cr_code%> - <%=cr_name%> <span class="coursecode">(<%=cr_code%>_<%=of_year%>_<%=sm_code%>_<%=dm_code%>)</span></h2>
  <div class="story">
    <h3>Summarise Cases</h3>
    <p>Select one or more cases, traits and info types to summarise. <br /> At least one case, one trait and one info type should be selected.</p>
 
    <form name="defsumry" id="defsumry" method="post" action="coursesumry.jhp">
      <table cellspacing="0">
      <thead>
        <tr>
          <th colspan="2">&nbsp;</th>
          <th><label for="ciid0">This is my first case</label></th>
          <th><label for="ciid1">This was a good case</label></th>
          <th><label for="ciid2">Don't think this case is bad</label></th>
          <th><label for="ciid3">not sure about this case</label></th>
          <th><label for="ciid4">Case 5</label></th>
          <th><label for="ciid5">Case 6</label></th>
        </tr>
        <tr>
          <th colspan="2"></th>
          <th><input type="checkbox" name="ciid" id="ciid0" /></th>
          <th><input type="checkbox" name="ciid" id="ciid1" /></th>
          <th><input type="checkbox" name="ciid" id="ciid2" /></th>
          <th><input type="checkbox" name="ciid" id="ciid3" /></th>
          <th><input type="checkbox" name="ciid" id="ciid4" /></th>
          <th><input type="checkbox" name="ciid" id="ciid5" /></th>
        </tr>
        </thead>
        <tbody id="trts">
        <tr class="r1">
          <th>Traits</th>
          <td>&nbsp;</td>
          <td class="tbltick">&nbsp;</td>
          <td class="tbltick">&nbsp;</td>
          <td class="tbltick">&nbsp;</td>
          <td class="tbltick">&nbsp;</td>
          <td class="tbltick">&nbsp;</td>
          <td class="tbltick">&nbsp;</td>
        </tr>
        <tr class="r2">
          <td class="tblheading2"><label for="traits0"><abbr title="Number of Lambs Born">NLB</abbr></label></td>
          <td><input type="checkbox" name="traits" id="traits0" /></td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&nbsp;</td>
          <td class="tbltick">&nbsp;</td>
        </tr>
        <tr class="r1">
          <td class="tblheading2"><label for="traits1"><abbr title="Fleece Weight at 12-months of age">FW12</abbr></label></td>
          <td><input type="checkbox" name="traits" id="traits1" /></td>
          <td class="tbltick">&nbsp;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&nbsp;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&#9679;</td>
        </tr>
        <tr class="r2">
          <td class="tblheading2"><label for="traits2"><abbr title="Live weight at 8-months of age">LW8</abbr></label></td>
          <td><input type="checkbox" name="traits" id="traits2" /></td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&nbsp;</td>
          <td class="tbltick">&nbsp;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&#9679;</td>
        </tr>
        <tr class="r1">
          <td class="tblheading2"><label for="traits3"><abbr title="Carcass Lean (kg)">LEAN</abbr></label></td>
          <td><input type="checkbox" name="traits" id="traits3" /></td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&nbsp;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&nbsp;</td>
        </tr>
        <tr class="r2">
          <td class="tblheading2"><label for="traits4"><abbr title="Carcass Fat (kg)">FAT</abbr></label></td>
          <td><input type="checkbox" name="traits" id="traits4" /></td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&nbsp;</td>
        </tr>
        </tbody>
        <tbody id="inftyps">
        <tr class="r1">
          <th>InfoTypes</th>
          <td>&nbsp;</td>
          <td class="tbltick">&nbsp;</td>
          <td class="tbltick">&nbsp;</td>
          <td class="tbltick">&nbsp;</td>
          <td class="tbltick">&nbsp;</td>
          <td class="tbltick">&nbsp;</td>
          <td class="tbltick">&nbsp;</td>
        </tr>
        <tr class="r2">
          <td class="tblheading2"><label for="inftyps0">Phenotypes</label></td>
          <td><input type="checkbox" name="inftyps" id="inftyps0" /></td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&nbsp;</td>
        </tr>
        <tr class="r1">
          <td class="tblheading2"><label for="inftyps1">Genotypes</label></td>
          <td><input type="checkbox" name="inftyps" id="inftyps1" /></td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&nbsp;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&#9679;</td>
        </tr>
        <tr class="r2">
          <td class="tblheading2"><label for="inftyps2">Est.&nbsp;Genotypes</label></td>
          <td><input type="checkbox" name="inftyps" id="inftyps2" /></td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&#9679;</td>
          <td class="tbltick">&nbsp;</td>
        </tr>
        </tbody>
        <tfoot>
        <tr class="tbltools">
          <td colspan="8"><input name="action" type="submit" value="Plot Summary" /><input name="action2" type="submit" value="Tabulate Summary" /></td>
        </tr>  
        </tfoot>      
      </table>
    </form> 
  </div>
  <!-- InstanceEndEditable --></div>
<!--end content -->
<!-- InstanceBeginEditable name="navbar" --><!-- InstanceEndEditable -->
<!--end navbar -->
<div id="siteInfo"> <img src="img/fill_clear.gif" alt="fill gif" width="1" height="1"/> <a href="mailto:R.G.Sherlock@massey.ac.nz">Contact Me</a> | &copy;2005-2008
  Ric Sherlock </div>
<br/>
</body>
<!-- InstanceEnd -->
</html>
