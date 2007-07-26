<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/default_user.dwt" codeOutsideHTMLIsLocked="false" -->
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
  <div id="globalNav"> 
  	<a href="http://www.massey.ac.nz" target="_blank">Massey University </a> | <a href="http://ivabs.massey.ac.nz" target="_blank">IVABS</a> | <a href="http://webct-ce.massey.ac.nz/webct/homearea/homearea?" target="_blank">Massey WebCT courses</a> | <a href="http://animalsim.massey.ac.nz/" target="_blank">AnimalSim website</a>
  </div> 
</div> 
<!-- end masthead --><div id="breadCrumb"><!-- InstanceBeginEditable name="breadCrumb" --><a href="default.jhp?action=logout">Logout</a> > <a href="user.jhp?action=home">myCourses</a> > <span class="current">CourseHome</span><!-- InstanceEndEditable --> </div>
<div id="contentNoNav"> 
  <!-- InstanceBeginEditable name="pgContent" -->
  <h2 id="pageName"><%=cr_code%> - <%=cr_name%> <span class="coursecode">(<%=cr_code%>_<%=of_year%>_<%=sm_code%>_<%=dm_code%>)</span></h2>
  <div class="story">
    <h3>Introduction</h3>
    <p><%=ox_intro%></p>
        <table cellspacing=0 width=78%><tr class=rh>
      <th>AnimalSim Cases</th> 
      </tr>
      <% for_idx. i.#cs_id do. %><tr class="r<%=,":2|idx%>">
        <td class="objlist"><a href="case.jhp?cs_id=<%= idx{cs_id %>"><%= idx{sd_name %></a> <span class="coursecode">(<%= dtb idx{sd_code%>)</span><br/>
            <%=idx{sd_descr%><br/>
            &nbsp;
            </td>
        </tr><% end. %>
    </table>
  </div>
<!-- InstanceEndEditable --></div> 
<!--end content --><!-- InstanceBeginEditable name="navbar" --><!-- InstanceEndEditable --> 
<!--end navbar --> 
<div id="siteInfo"> 
  <img src="img/fill_clear.gif" width="1" height="1"/> <a href="mailto:R.G.Sherlock@massey.ac.nz">Contact Me</a> | &copy;2005-2006
  Ric Sherlock
</div> 
<br/> 
</body>
<!-- InstanceEnd --></html>
