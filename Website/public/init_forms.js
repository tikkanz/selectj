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