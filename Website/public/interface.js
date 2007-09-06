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
	//gets the value of the scope key from the querystring, 'default' if not set.
	Querystring();
	cls = Querystring_get('scope','default'); 
	return cls
}

function setElementStyleByClassName(cl, propertyName, propertyValue) {
	//sets style property for Tags with specified class
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
	// handle unknown scope by defaulting to show class="default"
    if (cnt==0 && !(cl=='default'))	{ //need 2nd condition to prevent looping where no class="default"
		setElementStyleByClassName('default','display','inline')
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
function REVStatus() {
	var x=document.getElementsByName("objectvrevs")
	var y=document.getElementById("trts2select")
	if (y.length>0 && x.length>0) {
		for (i=0;i<y.length;++ i) {  //cycle through each option in Trts2Select listbox
			if (y[i].selected==true) {
				x[i].disabled=false;
				}
			else{
				x[i].disabled=true
				}
			}
		}
	}

function upldSelctdList() {
	//check that files specified in selected dams & selected sires, err msg box if not, otherwise submit
	var r=document.getElementById("UpldSL");
    var f=document.getElementById("Upld_fem").value;
	var m=document.getElementById("Upld_male").value;
	if (f.length==0 || m.length==0) {  //better to check if file exists at path specifed
		alert("You must specify the path to both the male and female selection lists");
		}
	else{
		//r.enctype="multipart/form-data";
		r.submit();
		}
	}

function callregsubmit() {
	//validates registration form
	frm=document.getElementById("regform");
	//flds=frm.getElementsByTagName("Input");
    var errs=0 ;
	var flds=new Array("uname","fname","lname","email","passwd");
	for (i=0;i<flds.length;++ i) { //cycle through each field	
		if (document.getElementById(flds[i]).value=="" ) {
			disp="inline";
			errs=errs+1;
			}
		else{
			disp="none";
			}
		document.getElementById(flds[i]+"Err").style["display"]=disp;
		}
	if (!(frm.passwd.value==frm.passwdc.value)) {
		disp="inline";
		errs=errs+1;
		}
	else{ disp="none";
		}
	document.getElementById("passwdc"+"Err").style["display"]=disp;
	if (errs<1) {
		frm.passwdc.disabled=true //disable so not sent
		frm.submit() 
		frm.passwdc.disabled=false
		}
	}