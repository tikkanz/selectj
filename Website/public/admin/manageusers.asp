<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/default.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta content="Ric Sherlock" name="author" />
<!-- InstanceBeginEditable name="pgtitle" -->
<title>AnimalSim</title>
<!-- InstanceEndEditable -->
<script language="JavaScript" src="../interface.js" type="text/javascript">
</script>
<link rel="stylesheet" href="../animalsim.css" type="text/css" />
<!-- InstanceBeginEditable name="stylesheets" -->
<link rel="stylesheet" href="adminstyle.css" type="text/css" />
<!-- InstanceEndEditable -->
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
<!-- end masthead --><div id="breadCrumb"><!-- InstanceBeginEditable name="breadCrumb" -->breadCrumb<!-- InstanceEndEditable --> </div>
<div id="contentNoNav"> 
  <!-- InstanceBeginEditable name="pgContent" -->
  <div id="breadCrumb"> </div>
  <h2 id="pageName">Manage Users </h2>
  <div class="story">
    <p>This is the admin page </p>
  </div>
  <form name="manageusers" id="manageusers" method="post" enctype="" action="">
    <input type="hidden" name="Filter" id="Filter" value="<%=fltr%>" />
<div class="Error<%=*#Error%>"><%=Error%></div>

<table id="listusers" width="81%" cellspacing=0>
  <tr class="tbltools">
    <td colspan="4"><input type="submit" name="action" value="Reset Selected" />
                   <input type="submit" name="action" value="Delete Selected" />
                    <a href="admin.jhp?action=Home&Filter=<%=fltralt%>">Show <%=fltralt%></a>
                    <a href="admin.jhp?action=Reset&urid=-99&Filter=<%=fltr%>">Reset all</a>
                    <a href="admin.jhp?action=Delete&urid=-99&Filter=<%=fltr%>">Delete all</a>
                    </td>
  </tr><tr><td valign=top>
    <table cellspacing=0 width=98%><tr class="rh">
      <th>&#160;</th> 
      <th>UserID</th>
      <th>Active</th>
      <th>First</th>
      <th>Last</th>
      </tr>
      <% if. #ur_id do.
	     for_i. i.#ur_id do. %>
        <tr class="r<%=(selected~:i{ur_id){'s',":2|i%>">
        <td><input type="checkbox" name="urid" id="urid<%=i%>"  value="<%= i{ur_id %>"></td>
        <td><a href="admin.jhp?action=Index&urid=<%=i{ur_id %>&Filter=<%=fltr%>"><%= i{ur_id %></a></td>
        <td><span><%= i{ur_status %></span> </td>
        <td><span><%= i{pp_fname %></span> </td>
        <td><span><%= i{pp_lname %></span> </td>
        </tr>
	  <% end. 
	    end.%>
    </table>
    </td>
    <td colspan="3" valign="top">
    <fieldset><legend>User Info</legend>
      <table cellspacing="0">
        <tr>
        <th width="78" class="rh">UserID</th>
        <td width="93"><%= 'ur_id'keyval Item%></td>
      </tr><tr>
        <th class="rh">Name</th>
        <td><%='pp_fname'keyval Item%> <%='pp_lname'keyval Item%></td>
      </tr>
      <tr>
        <th class="rh">Username</th>
        <td><%= 'ur_uname'keyval Item%></td>
      </tr>
      <tr>
        <th class="rh">StudentID</th>
        <td><%= 'ur_refnum'keyval Item%></td>
      </tr>
      <tr>
        <th class="rh">Email</th>
        <td><%= 'pp_email'keyval Item%></td>
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
ur_id
<%print Uids %>
Item
<%print Item %>
</pre> -->
<script>
function cmd(name, item) {
  var F1 = document.getElementById("manageusers");
  if (name) F1.action.value = name;
  if (item != null) F1.Index.value = item;
  F1.submit();
}
</script>
<!-- InstanceEndEditable --></div> 
<!--end content --><!-- InstanceBeginEditable name="navbar" --><!-- InstanceEndEditable --> 
<!--end navbar --> 
<div id="siteInfo"> 
  <img src="../img/fill_clear.gif" alt="fill gif" width="1" height="1"/> <a href="mailto:R.G.Sherlock@massey.ac.nz">Contact Me</a> | &copy;2005-2008
  Ric Sherlock
</div> 
<br/> 
</body>
<!-- InstanceEnd --></html>
