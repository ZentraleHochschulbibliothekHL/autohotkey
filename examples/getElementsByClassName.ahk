#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Persistent
 
F2::
wb := IEGet() 
if !wb {
	msgbox, IE pointer not found!
	return
}
wb.Silent := true
wb.Navigate("http://autohotkey.com")
while wb.ReadyState != 4 {
	Sleep 10
	if (A_TickCount-initTime > 2000)
		throw 1
}




/*
	<ul class="article-additional-info">
	   <li><strong>Issue Year:</strong> 2011</li>
	   <li><strong>Issue No:</strong> 1 (200)</li>
	   <li><strong>Page Range:</strong> 65-80</li>
	   <li><strong>Page Count:</strong> 15</li>
	   <li><strong>Language:</strong> Polish</li>
	</ul>
	*/


MyClass := wb.document.GetElementsByClassName("mbr-section")

Loop, % MyClass.Length
{
	if ( MyClass[(A_Index-1)].NodeName == "UL")
	{	
		UL_InnerHTML := MyClass[(A_Index-1)].InnerHTML
		break
	}
}

d := Object()
d.Length := 0

Loop, parse, UL_InnerHTML, `n, `r
{
	
	
	IfNotInString, A_LoopField, <li>
		continue

	NewStr := StrReplace(A_LoopField, "<li><strong>", " ` ")
	NewStr := StrReplace(NewStr, "</strong>", "``")
	NewStr := StrReplace(NewStr, "</li>", "``")
	NewStr := StrReplace(NewStr, ":", "")
	StrArray := StrSplit(NewStr, "``")
	
	key := StrReplace(StrArray[1], A_Space, "")
	value := StrArray[2]
	
	d[(key)] := value
	d.Length += 1
	  
	
}

msgbox, % d.IssueYear "`n" d.IssueNo "`n" d.PageRange "`n" d.PageCount "`n" d.Language

for k,v in d
    MsgBox % "Key:     " k " `nValue: " v

return



 
IEGet(Name="")        ;Retrieve pointer to existing IE window/tab
{
IfEqual, Name,, WinGetTitle, Name, ahk_class IEFrame
	Name := ( Name="New Tab - Windows Internet Explorer" ) ? "about:Tabs"
	: RegExReplace( Name, " - (Windows|Microsoft) Internet Explorer" )
For wb in ComObjCreate( "Shell.Application" ).Windows
	If ( wb.LocationName = Name ) && InStr( wb.FullName, "iexplore.exe" )
		Return wb
	If InStr( wb.FullName, "iexplore.exe" ) 
		Return wb
}