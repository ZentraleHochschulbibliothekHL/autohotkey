
WBGet(WinTitle:="ahk_class IEFrame", Svr:=1) {
	static msg := DllCall("user32\RegisterWindowMessage", Str, "WM_HTML_GETOBJECT", UInt)
	IID := "{0002DF05-0000-0000-C000-000000000046}"
	lResult := SendMessage(msg, 0, 0, "Internet Explorer_Server" Svr, WinTitle)
    if (lResult != "") {
		VarSetCapacity(GUID,16,0)
		if (DllCall("ole32\CLSIDFromString", WStr,"{332C4425-26CB-11D0-B483-00C04FD90119}", Ptr,&GUID) >= 0) {
			DllCall("oleacc\ObjectFromLresult", Ptr,lResult, Ptr,&GUID, UPtr,0, PtrP,pdoc)
			obj := ComObject(9,ComObjQuery(pdoc,IID,IID),1)
			ObjRelease(pdoc)
			return obj
		}
	}
}