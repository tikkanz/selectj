<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/default_static.dwt" codeOutsideHTMLIsLocked="false" -->
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
<!-- InstanceParam name="JavascriptInHeader" type="boolean" value="false" -->
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
<!-- end masthead --> 

<div id="contentNoNav"> 
  <!-- InstanceBeginEditable name="pgContent" -->
  <div id="breadCrumb"> </div>
  <h2 id="pageName">User Home Page</h2>
  <div class="story">
    <h3>Hi <%= fname %> <%= lname %></h3>
        <table cellspacing=0 width=98%><tr class=rh>
      <th>&#160;</th> <th>Name</th> <th>Amount</th>
    </tr>
      <% for_i. i.#Names do. %><tr class="r<%=(Index~:i){'s',":2|i%>">
        <td><input type=checkbox name=Select  value="<%= i %>"></td>
        <td><a href="javascript:cmd('Index',<%=i%>)"><%= i{::Names %></a>
		    <input type=hidden   name=Names   value="<%= i{::Names %>"></td>
        <td><span><%= i{::Amounts %></span>
		    <input type=hidden   name=Amounts value="<%= i{::Amounts %>"></td>
      </tr><% end. %>
    </table>
  </div>
<!-- InstanceEndEditable --></div> 
<!--end content --> 
<!--end navbar --> 
<div id="siteInfo"> 
  <img src="img/fill_clear.gif" width="1" height="1"/> <a href="mailto:R.G.Sherlock@massey.ac.nz">Contact Me</a> | &copy;2005-2006
  Ric Sherlock
</div> 
<br/> 
</body>
<!-- InstanceEnd --></html>
