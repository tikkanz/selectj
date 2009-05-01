<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/default_course.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta content="Ric Sherlock" name="author" />
<!-- InstanceBeginEditable name="pgtitle" -->
<title>AnimalSim Live</title>
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
  <h1 id="siteName">AnimalSim Live - <span class="small"><%=pp_fname%> <%=pp_lname%> logged in</span></h1> 
  <div id="globalNav"> 
  	<a href="http://www.massey.ac.nz" target="_blank">Massey University </a> | <a href="http://ivabs.massey.ac.nz" target="_blank">IVABS</a> | <a href="http://webct-ce.massey.ac.nz/webct/homearea/homearea?" target="_blank">Massey WebCT courses</a> | <a href="http://animalsim.massey.ac.nz/" target="_blank">AnimalSim website</a>
  </div> 
</div> 
<!-- end masthead --><div id="breadCrumb"><!-- InstanceBeginEditable name="breadCrumb" --><a href="default.jhp?action=logout">Logout</a> &gt; <a href="user.jhp?action=home">myCourses</a> &gt; <span class="current">CourseHome</span><!-- InstanceEndEditable --> </div>
<div class="courseName"><!-- InstanceBeginEditable name="courseName" --><%= cr_code%> - <%= cr_name %> <span class="objcode">(<%=cr_code%>_<%=of_year%>_<%=sm_code%>_<%=dm_code%>)</span><!-- InstanceEndEditable --></div>

<div id="contentNoNav"> 
  <!-- InstanceBeginEditable name="pgContent" -->
  <div class="story">
    <h3>Introduction</h3>
    <p><%=offtext%></p>
        <table cellspacing=0 width=78%><thead><tr class=rh>
      <th>AnimalSim Cases</th>
      </tr></thead>
      <tbody>
      <% for_idx. i.#cs_id do. %><tr class="r<%=,":2|idx%>">
        <td class="objlist"><span class="objname"><a href="case.jhp?cs_id=<%= idx{cs_id %>"><%= idx{sd_name %></a></span> <span class="objcode">(<%= dtb idx{sd_code%>)</span><br/>
            <%=idx{sd_descr%><br/>
            &nbsp;
            </td>
        </tr><% end. %>
      </tbody>
      <tfoot>
        <tr class="tbltools">
          <td><form name="storedcases" id="storedcases" action="coursesumry.jhp"> <input type="submit" value="Analyse saved cases" title="Summarise and analyse cases you have previously completed and saved for this course" /></form></td>
        </tr>
      </tfoot>
    </table>
  </div>
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
