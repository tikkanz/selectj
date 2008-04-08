<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta content="Ric Sherlock" name="author" />

<title>AnimalSim</title>

<script language="JavaScript" src="interface.js" type="text/javascript">
</script>
<link rel="stylesheet" href="animalsim.css" type="text/css" />
<link rel="stylesheet" href="forms.css" type="text/css" />
</head>
<body onload="disableForm('params')">
<div class="courseName"><%= cr_code%> - <%= cr_name %></div>
<div id="content">
  <div id="caseInfo">
    <div id="caseName"><h2><%= sd_name %> <span class="objcode" title="ID number for your case">(<%=cinstid%>)</span> <span class="subhead"><%=ci_usrname%></span></h2>
      <p><%= sd_descr %> </p>
    </div>
  </div>
  <div class="story">
     <h3><%= xn_name %> </h3>
     <p>Close this window to return to your list of stored cases.</p>
      <%=caseform%>  </div>
</div> 
<!--end content -->
<div id="siteInfo"> 
  <img src="img/fill_clear.gif" alt="fill gif" width="1" height="1"/> <a href="mailto:R.G.Sherlock@massey.ac.nz">Contact Me</a> | &copy;2005-2008
  Ric Sherlock
</div> 
<br/>
</body>
</html>
