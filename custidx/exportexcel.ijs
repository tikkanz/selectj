NB. =========================================================
NB. Format & Output Reports to Clients using Excel & Tara

NB. ---------------------------------------------------------
NB. PDFs/Excel files/Print
NB. Can write one Excel workbook with 2 sheets per client List & details
NB.  -could then create PDFs or print from that
NB.  -might be able to set up header & footer so that printing all
NB.   automatically has individual client info
NB.  -print sheets for each client by selecting both and File/Print
NB.  -Quick but no page numbers would be to change footer to have 
NB.   no page numbers, could then print whole workbook at once
NB. It is not easier to create one workbook per client

NB. Could Format in Grid & print directly from there?
NB.  -not sure if possible or easy ** possible but not easy yet
NB. Could also use printn which says it prints characters as columns
NB.  -would print directly to printer
NB.  -colours & formating might be difficult?

NB. Use the Publish framework (ex JAL package) for creating PDFs from HTML
NB.  -so could create HTML & then PDFs
NB.  -sounds complicated but might be useful if go web way at some stage

NB. ---------------------------------------------------------

NB.   wdinfo 'fnme';fnme

NB. RETRIEVE INFO (same for all output methods)
NB. Which client(s) to export reports for?
NB. Prompt for excel file name (xx.xls) to create 
NB. Use sqlsel_Index_List to get current revs & value
NB. calculate Index Lists for each client 
NB. sort each Index_List by Ranking
NB. Handle clients without current revs & value 
NB.  -(Error & Return? or disable export for individual)

NB. Get Scenario info for each client
NB. Get PriceProfile info for each client
NB. Handle clients with manually specified revs & value (no profile or scenario)

NB. Get Address info for each client

NB. OUPUT INFO
NB. Write Info to Excel using Tara

NB.   bi=: ('Arial' ; 200) conew 'biffbook'
NB.    writestring__bi 1 3 ; 'hello world'    NB. write text in a cell: rowcol ; text (rowcol is 0-based)
NB.    writestring__bi 'C4' ; 'hello Tara'    NB. cell in "A1" mode
NB.    writenumber__bi 'C3' ; o.1
NB.    save__bi jpath '~temp/tara1.xls'       NB. save to a file
NB.    destroy__bi ''                         NB. destriy workbook object, NOT the Excel file
NB.    l=: 0{sheet__bi              NB. worksheet object
NB.    defaultcolwidth__l=: 5       NB. number of characters of first predefined font
NB.    NB. set default row height
NB.    defaultrowheight__l=: 400    NB. twip
NB.    NB. set individual column width
NB.    NB. y. is firstcol lastcol width(in 1/256 character)
NB.    addcolinfo__bi 2 6, 256*10
NB.    NB. set individual row height
NB.    NB. y. is rownumber firstcol lastcol+1 usedefaultheight rowheight(in twip) heightnotmatch ...
NB.    addrowinfo__bi 1 0 256 0 1000 1
NB. The xf object is the equivalent of "format cell dialog", so
NB. you know why xf is useful but complicated.
NB. Tara will create a xf object called 'cxf' (current xf) when
NB. initializing a workbook.  Using cxf, you can set various cell
NB. formats.
NB. First create a workbook and get its cxf.  Note xf is just an
NB. alias of cxf__bi not a new object.

NB.  bi=: ('Courier New' ; 220) conew 'biffbook'  NB. default font
NB.  xf=: cxf__bi            NB. current workbook xf object
NB.  xf1=: addxfobj__bi xf   NB. clone xf for later use
NB.  horzalign__xf=: 3
NB.  xf1 writestring__bi 2 3 ; 'xf1'   NB. xf1 object as left argument

NB. Formats
NB. ============
NB. ?!?Forget about borders?!?

NB. Indexes page
NB. ------------
NB. Base format (MFD? Yld? GFW? CFW? CV%)
NB. fontname__xf=: 'Arial'  NB. no need to use double quotes (")
NB. fontheight__xf=: 200  NB. twip (points=twip%20)
NB. fontweight__xf=: 400  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0    NB. italic
NB. fontcolor__xf=: rgbcolor__bi 0 0 0  NB. black
NB. horzalign__xf=: 3  NB. right
NB. vertalign__xf=: 2  NB. bottom
NB. format__xf=: '0.0'  NB. format string
NB.NB. patterncolor__xf=: rgbcolor__bi 16bff 16bff 16b99 NB. light yellow
NB.
NB. Lot No
NB. - Font Arial 10 Black
NB. fontheight__xf=: 200
NB. fontweight__xf=: 400  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 3  NB. right
NB. vertalign__xf=: 2  NB. bottom
NB. format__xf=: '0'  NB. 0 decimal places
NB. rightlinestyle__xf=: cellborder_light_biff_ NB. right border light
NB.
NB. EBV
NB. - Font Arial 10 Bold Black 
NB. fontheight__xf=: 200
NB. fontweight__xf=: 700  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 3  NB. right
NB. vertalign__xf=: 2  NB. bottom
NB. format__xf=: '0.00'  NB. 2 decimal places
NB. rightlinestyle__xf=: cellborder_light_biff_ NB. right border light
NB.
NB. Index
NB. - Font Arial 10 Bold Italics Black 
NB. fontheight__xf=: 200
NB. fontweight__xf=: 700  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 1
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 2  NB. center
NB. vertalign__xf=: 2  NB. bottom
NB. format__xf=: '0.00'  NB. 2 decimal places
NB. rightlinestyle__xf=: cellborder_light_biff_ NB. right border light
NB.
NB. Ranking
NB. - Font Arial 10 Bold Black
NB. fontheight__xf=: 200
NB. fontweight__xf=: 700  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 2  NB. center
NB. vertalign__xf=: 2  NB. bottom
NB. format__xf=: '0'  NB. 0 decimal places
NB.
NB. Sire
NB. patterncolor__xf=: rgbcolor__bi 16bcc 16b99 16bff NB. Lavender
NB. - Font Arial 10 Bold Black
NB. fontheight__xf=: 200
NB. fontweight__xf=: 700  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 3  NB. right
NB. vertalign__xf=: 2  NB. bottom
NB. format__xf=: 'Text'  NB.  Text
NB. rightlinestyle__xf=: cellborder_light_biff_ NB. right border light
NB. leftlinestyle__xf=: cellborder_light_biff_ NB. right border light
NB.
NB. Tag
NB. patterncolor__xf=: rgbcolor__bi 16bcc 16bff 16bff NB. light turquoise
NB. - Font Arial 10 Black
NB. fontheight__xf=: 200
NB. fontweight__xf=: 400  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 3  NB. right
NB. vertalign__xf=: 2  NB. bottom
NB. format__xf=: 'Text'  NB.  Text
NB.
NB. Value
NB. - Font Arial 10 Black
NB. fontheight__xf=: 200
NB. fontweight__xf=: 400  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 3  NB. right
NB. vertalign__xf=: 2  NB. bottom
NB. format__xf=: '$#,##0'  NB. Currency, 0 decimal places

NB. Details page
NB. ------------
NB.
NB. Heading Section
NB. patterncolor__xf=: rgbcolor__bi 3#16bff NB. white
NB. - Font Arial 14 Bold Italics Black
NB. fontheight__xf=: 280
NB. fontweight__xf=: 700  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 1
NB. fontcolor__xf=: rgbcolor__bi 0 0 0  NB. black
NB. horzalign__xf=: 1  NB. left
NB. vertalign__xf=: 2  NB. bottom
NB.
NB. Heading Column
NB. patterncolor__xf=: rgbcolor__bi 16b00 16b00 16b80 NB. dark blue
NB. - Font Arial 10 Bold Italic White
NB. fontheight__xf=: 200
NB. fontweight__xf=: 700  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 1
NB. fontcolor__xf=: rgbcolor__bi 255 255 255  NB. white
NB. horzalign__xf=: 2  NB. center
NB. vertalign__xf=: 2  NB. bottom

NB.
NB. Heading Row
NB. patterncolor__xf=: rgbcolor__bi 3#16bff NB. white
NB. - Font Arial 10 Bold Black
NB. fontheight__xf=: 200
NB. fontweight__xf=: 700  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 3  NB. right
NB. vertalign__xf=: 2  NB. bottom

NB.
NB. Heading Summary
NB. patterncolor__xf=: rgbcolor__bi 3#16bcc NB. light grey
NB. - Font Arial 11 Bold Black
NB. fontheight__xf=: 220
NB. fontweight__xf=: 700  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 2  NB. center
NB. vertalign__xf=: 0  NB. top

NB.
NB. Value Supplied
NB. patterncolor__xf=: rgbcolor__bi 16bcc 16bcc 16bff NB. light blue
NB. - Font Arial 10 Black
NB. fontheight__xf=: 200
NB. fontweight__xf=: 400  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 2  NB. center
NB. vertalign__xf=: 2  NB. bottom

NB.
NB. Value Calculated
NB. patterncolor__xf=: rgbcolor__bi 3#16bcc NB. light grey
NB. - Font Arial 10 Black
NB. fontheight__xf=: 200
NB. fontweight__xf=: 400  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 2  NB. center
NB. vertalign__xf=: 2  NB. bottom

NB. Value Summary
NB. patterncolor__xf=: rgbcolor__bi 3#16bcc NB. light grey
NB. - Font Arial 11 Black
NB. fontheight__xf=: 220
NB. fontweight__xf=: 400  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 2  NB. center
NB. vertalign__xf=: 2  NB. bottom

NB. REVs
NB. patterncolor__xf=: rgbcolor__bi 16bff 16b99 16bcc NB. rose
NB. - Font Arial 11 Bold Black
NB. fontheight__xf=: 220
NB. fontweight__xf=: 700  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 2  NB. center
NB. vertalign__xf=: 0  NB. top

NB. Percent
NB. format__xf=: '0'  NB. 0 decimal places

NB. kg
NB. format__xf=: '0'  NB. 0 decimal places

NB. $/kg

NB. 