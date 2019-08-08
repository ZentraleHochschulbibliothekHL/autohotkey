#Include, <IME>
#Include, <WBGet_V11>

#SingleInstance, force

^j::
Run, iexplore.exe http://www.share.go.kr
WinGet, hWnd, ID, ahk_class IEFrame
oWB := WBGet("ahk_id " hWnd)
vEltClass := "btn btn-success"
MsgBox, % oWB.document.getElementsByClassName(vEltClass).length
oElt := oWB.document.getElementsByClassName(vEltClass)[0]
MsgBox, % oElt.innerText
MsgBox, % oElt.outerHTML
oElt.click()
oWB := ""
return

; ^j::
; IME_SetEnglish()
; Send, This is English{Enter}
; IME_SetKorean()
; Send, dkssudgktpdy, gksrmfdlqslek.{Enter}

