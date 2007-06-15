//========================================================== 
/* functions to dynamically display desired class based on value of 'scope' key in URL
   RGS June 2007
   Options:
   a) using functions here [all javascript]
   b) [replace getScope() with J version in JHP handler file (Markup-behind)
      and use <%= %> to specify value of scope in HTML. [combined JHP & javascript]
	  But means that can't navigate directly to HTML file.
   c) store content somewhere else (database/textfile/jhp file) and use <%= %>
      to insert appropriate content based on URI. [all JHP]
	  Have to generate & store presentation separately to html files. Might be sensible 
	  if content is "data" e.g. description of animalsim scenario template
*/
function getScope(){
	Querystring();
	cls = Querystring_get('scope','default'); //gets the value of the scope key from the querystring, 'default' if not set.
	return cls
}

function setElementStyleByClassName(cl, propertyName, propertyValue) {
    if (!document.getElementsByTagName) return;
	var cnt=0;
    var re = new RegExp("(^| )" + cl + "( |$)");
    var el = document.all ? document.all :
      document.getElementsByTagName("body")[0].getElementsByTagName("*");
      // fix for IE5.x
    for (var i = 0; i < el.length; i++) {
        if (el[i].className &&  el[i].className.match(re)) {
            el[i].style[propertyName] = propertyValue;
			cnt=cnt+1;
        }
    }
	// handle unknown scope
    if (cnt==0 && !(cl=='default'))	{
		setElementStyleByClassName('default','display','inline')
	}
}
//==================================================
/* functions to help reset the state of the controls on a form.
   RGS 2006
*/
function myformInit(objnms,inivrs)
	{
	for(m=0;m<objnms.length;++ m)  //cycle through each of the object names
		{
		var fxt=document.getElementById(objnms[m])
		switch(fxt.type) 	//is it txtbox,listbox,chkbox,radio?
			{
			case "select-multiple":
			case "select-one":
				//alert(m + " This is " + fxt.name)
				selectInit(objnms[m],inivrs[m])
				break;
			case "text":
				if (fxt.name=="ObjectvREVs")
					{
					//alert(m + " This is " + fxt.name)	
					REVarrayInit(objnms[m],inivrs[m])
					}
				else
					{
					txtarryInit(objnms[m],inivrs[m])
					}
				break;
			case "radio":
			case "checkbox":
				cbxradInit(objnms[m],inivrs[m])
				break;
			default:
				alert("Unknown object type")
				break;
			}
		}

	}

function REVarrayInit(objnme,inivar)
	{  //special function to set items of REV array
	var x=document.getElementsByName(objnme)
	var y=document.getElementById("Trts2Select")
	var j=0
	for (i=0;i<y.length;++ i)  //cycle through each option in Trts2Select listbox
		{
		if (y[i].selected==true)
			{
			x[i].value=inivar[j];
			j=j+1;
			}
		else
			{
			x[i].disabled=true
			}
		}
	}

function selectInit(objnme,inivar)
	{ 	//generalised function to select option objects of a select object given array of values to match
	var x=document.getElementById(objnme)
	for (i=0;i<x.length;++ i)  //cycle through each option in listbox
		{
		for (j=0;j<inivar.length;++ j)  //cycle through each inivar item
			{
			if (inivar[j]==x[i].value)  //if they match select listbox option
				{
				x[i].selected=true
				}
			}
		}	
	}
function cbxradInit(objnme,inivar)
	{  //generalised function to select option objects of a checkbox or radio button object given array of values to match
	var x=document.getElementsByName(objnme)
	//var tmp=document.getElementById("FlkSizes")
	//	tmp.value=x.length
	for (i=0;i<x.length;++ i)     //cycle through objects with same name
		{
		for (j=0;j<inivar.length;++ j)  //cycle through inivar item
			{
			if (inivar[j]==x[i].value)  //if they match select checkbox or radio button
				{
				x[i].checked=true
				}
			}
		}	
	}
	
function txtarryInit(objnme,inivar)
	{
	var x=document.getElementsByName(objnme)
	for (i=0;i<x.length;++ i)   //cycle through text elements with same name
		{
		x[i].value=inivar[i]   //assign respective value
		}
	}

//========================================================== 
/* general functions for handling AnimalSim web interface
   RGS 2006
*/
function AddtoOne()
    { 
	/* send with function call or somehow get index of object that changed in list of objects with same name
	   chgd=get value of that object
	   set value of other object to be 1-chgd
	   or value of last of other objects to be 1-(sum of all except last of other objects)
	*/
	}
function REVStatus()
	{
	var x=document.getElementsByName("ObjectvREVs")
	var y=document.getElementById("Trts2Select")
	for (i=0;i<y.length;++ i)  //cycle through each option in Trts2Select listbox
		{
		if (y[i].selected==true)
			{
			x[i].disabled=false;
			}
		else
			{
			x[i].disabled=true
			}
		}
	}

function formSubmit()
	{
	document.getElementById("id").disabled=false;
	document.getElementById("FlkSizes").disabled=false;
	document.getElementById("nCycles").disabled=false;
	document.getElementById("CurrYear").disabled=false;
    /*if (!document.getElementById("CurrYear")==undefined)
		{
		document.getElementById("CurrYear").disabled=false;
		} */	
	document.getElementById("ViewFlkParams").submit();
    }
/*function dwnldSelnList()
	{
	//change form action to download and disable unecessary fields (Don't get sent)
	var r=document.forms[0]
	//document.getElementById("UploadFileF").disabled=true
	//document.getElementById("UploadFileM").disabled=true
	r.action="SelnList.csv"
	//alert("form action is " + r.action)
	r.submit()
    }
*/
function upldSelctdList()
	{
	//check that files specified in selected dams & selected sires, err msg box if not, otherwise submit
	var r=document.getElementById("NextSelnCycle");
    var f=document.getElementById("UploadFileF").value;
	var m=document.getElementById("UploadFileM").value;
	if (f.length==0 || m.length==0)  //better to check if file exists at path specifed
		{
			alert("You must specify the path to both the male and female selection lists");
		}
	else
		{
			//alert("f.length is: " + f.length + "m.length is: " + m.length)
			r.submit();
		}
	//r.enctype="multipart/form-data"
	//r.action="Mate"
	//alert("form action is " + r.action)
	//r.submit()
	}

function subWindow()  //used by Graphing module
	{
    if (arguments.length < 1) {
        alert("function subWindow called with " + arguments.length +
              " arguments, but it expects at least 1 arguments.");
        return null;
    }
    var widthval = arguments[1] != null ? arguments[1] : 400;
    var heightval = arguments[2] != null ? arguments[2] : 200;
    var filename = arguments[3] != null ? arguments[3] : "";
    var dimensions = "height="+heightval+",width="+widthval;
	            //",resizable=0,statusbar=0,hotkeys=0,menubar=0,scrollbars=0,status=0,toolbar=0";
	var newWindow = window.open(filename,arguments[0],dimensions);
    /* if (!filename) {
        newWindow.document.write("<title>AnimalSim Graph</title>")
        newWindow.document.write("<center><font size=4>Loading, please wait...</font></center>")
    } */
    newWindow.focus()
    return;
}
