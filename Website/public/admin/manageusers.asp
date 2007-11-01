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
    <p>This page can be used to manage users.</p>
  </div>
  <form name="manageusers" id="manageusers" method="post" enctype="" action="">
    <input type="hidden" name="active" id="active" value="<%=fltractiv%>" />
    <input type="hidden" name="guest" id="guest" value="<%=fltrguest%>" />
    <div class="Error<%=*#Error%>"><%=Error%></div>
<table cellspacing=0>
  <tr class="tbltools">
    <td colspan="2">
      <input type="submit" name="action" value="Reset Selected" />
      <input type="submit" name="action" value="Delete Selected" />
      <a href="admin.jhp?action=Home&active=<%=fltractivalt%>&guest=<%=fltrguest%>">Show <%=fltractivaltmsg%></a>
      <a href="admin.jhp?action=Home&active=<%=fltractiv%>&guest=<%=fltrguestalt%>"><%=fltrguestaltmsg%></a>      
      <a href="admin.jhp?action=Reset&urid=-99&active=<%=fltractiv%>&guest=<%=fltrguest%>">Reset all</a>
      <a href="admin.jhp?action=Delete&urid=-99&active=<%=fltractiv%>&guest=<%=fltrguest%>">Delete all</a>
    </td>
  </tr>
  <tr>
    <td valign="top">
    <fieldset><legend>User list</legend>
    <table id="userlist" class="tbldetails" cellspacing=0 width="100%"><tr class="rh">
      <th colspan="2">UserID</th>
      <th>First</th>
      <th>Last</th>
      <th>Active</th>
      </tr>
      <% if. #ur_id do.
	     for_i. i.#ur_id do. %>
        <tr class="r<%=(selected~:i{ur_id){'s',":2|i%>">
        <td class="tblheading2"><a href="admin.jhp?action=Index&urid=<%=i{ur_id %>&active=<%=fltractiv%>&guest=<%=fltrguest%>"><%= i{ur_id %></a></td>
        <td><input type="checkbox" name="urid" id="urid<%=i%>"  value="<%= i{ur_id %>"></td>
        <td><label for="urid<%=i%>"><%= i{pp_fname %></label></td>
        <td><%= i{pp_lname %></td>
        <td><%= i{ur_status %></td>
        </tr>
	  <% end. 
	    end.%>
    </table>
    </fieldset>
    </td>
    <td valign="top">
    <% if. 0<:4!:0 <'Item' do. %>
    <fieldset><legend>User details</legend>
      <table id="userrec" class="tbldetails" cellspacing="0">
        <tr>
          <th class="rh">UserID</th>
          <td><%= 'ur_id'keyval Item%></td>
        </tr>
        <tr>
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
    <% end. %>
  </td>
  </tr>
  </table>
</form>
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
