<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/default_static.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta content="Ric Sherlock" name="author" />
<!-- InstanceBeginEditable name="pgtitle" -->
<title>AnimalSim</title>
<!-- InstanceEndEditable -->
<script language="JavaScript" src="../interface.js" type="text/javascript">
</script>
<link rel="stylesheet" href="../2col_leftNav.css" type="text/css" />
<!-- InstanceBeginEditable name="stylesheets" -->
<link rel="stylesheet" href="adminstyle.css" type="text/css" />
<!-- InstanceEndEditable -->
<!-- InstanceParam name="JavascriptInHeader" type="boolean" value="false" -->
<!-- InstanceParam name="bodyOnload" type="text" value="" -->

</head>
<body onload="">
<div id="masthead">
  <div id="logo"><a href="../default.jhp"><img src="../img/deltag.png" alt="AnimalSim home" width="91" height="55" border="0" /></a></div> 
  <h1 id="siteName"><!-- InstanceBeginEditable name="SiteName" -->AnimalSim Web Admin<!-- InstanceEndEditable --></h1> 
  <div id="globalNav"> 
  	<a href="http://www.massey.ac.nz" target="_blank">Massey University </a> | <a href="http://ivabs.massey.ac.nz" target="_blank">IVABS</a> | <a href="http://webct-ce.massey.ac.nz/webct/homearea/homearea?" target="_blank">Massey WebCT courses</a> | <a href="http://animalsim.massey.ac.nz/" target="_blank">AnimalSim website</a>
  </div> 
</div> 
<!-- end masthead --> 

<div id="contentNoNav"> 
  <!-- InstanceBeginEditable name="pgContent" -->
  <div id="breadCrumb"> </div>
  <h2 id="pageName">Manage Users </h2>
  <div class="story">
    <p>This is the admin page </p>
  </div>
  <form name="F1" id="F1" method="post" enctype="" action="">
  <input type="hidden" name="Command" value="">
  <input type="hidden" name="Index" value="">
<div class="Error<%=*#Error%>"><%=Error%></div>

<table id="listusers" width="81%" cellspacing=0>
  <tr class="Tools">
    <td width=57%><a href="javascript:cmd('Reset')">Reset Selected</a> <a href="javascript:cmd('Delete')">Delete Selected</a></td>
    <td width=5%>&#160;</td>
    <td width="18%"><a href="javascript:cmd('Reset',-99)">Reset all</a></td>
    <td width="20%"><a href="javascript:cmd('Delete',-99)">Delete all</a></td>
  </tr><tr><td valign=top>
    <table cellspacing=0 width=98%><tr class="rh">
      <th>&#160;</th> 
      <th>UserID</th>
      <th>Active</th>
      <th>First</th>
      <th>Last</th>
      </tr>
      <% for_i. i.#Uids do. %><tr class="r<%=(Index~:i){'s',":2|i%>">
        <td><input type="checkbox" name="Select"  value="<%= i %>"></td>
        <td><a href="javascript:cmd('Index',<%=i%>)"><%= i{::Uids %></a>
		    <input type="hidden"   name="Uids"   value="<%= i{::Uids %>"></td>
        <td><span><%= i{::Actives %></span> </td>
        <td><span><%= i{::Fnames %></span> </td>
        <td><span><%= i{::Lnames %></span> </td>
        </tr><% end. %>
    </table>
    </td>
    <td colspan="3" valign="top">
    <fieldset><legend>Item</legend>
      <table cellspacing="0">
        <tr>
        <th width="78" class="rh">UserID</th>
        <td width="93"><%= 'ur_id'keyval Item%></td>
      </tr><tr>
        <th class="rh">Name</th>
        <td><%='ur_fname'keyval Item%> <%='ur_lname'keyval Item%></td>
      </tr>
      <tr>
        <th class="rh">Username</th>
        <td><%= 'ur_uname'keyval Item%></td>
      </tr>
      <tr>
        <th class="rh">StudentID</th>
        <td><%= 'ur_studentid'keyval Item%></td>
      </tr>
      <tr>
        <th class="rh">Email</th>
        <td><%= 'ur_email'keyval Item%></td>
      </tr>
      <tr>
        <th class="rh">Status</th>
        <td><%= 'ur_status'keyval Item%></td>
      </tr>
      <tr>
        <th class="rh">Salt</th>
        <td><%= 'ur_salt'keyval Item%></td>
      </tr>
      <tr>
        <th class="rh">PassHash</th>
        <td><%= 'ur_passhash'keyval Item%></td>
      </tr>
      </table>
    </fieldset>
  </td></tr></table>
</form>
<!-- <pre>
CGIKEYS
<%print CGIKEYS %>
CGIVALS
<%print CGIVALS %>
Select
<%print Select %>
Uids
<%print Uids %>
Index
<%print Index %>
Item
<%print Item %>
</pre> -->
<script>
function cmd(name, item) {
  var F1 = document.getElementById("F1");
  if (name) F1.Command.value = name;
  if (item != null) F1.Index.value = item;
  F1.submit();
}
</script>
<!-- InstanceEndEditable --></div> 
<!--end content --> 
<!--end navbar --> 
<div id="siteInfo"> 
  <img src="../img/fill_clear.gif" width="1" height="1"/> <a href="mailto:R.G.Sherlock@massey.ac.nz">Contact Me</a> | &copy;2005-2006
  Ric Sherlock
</div> 
<br/> 
</body>
<!-- InstanceEnd --></html>
