Send_ImeControl(DefaultIMEWnd, wParam, lParam) {
    DetectSave := A_DetectHiddenWindows 
    DetectHiddenWindows,ON 
    SendMessage 0x283, wParam,lParam,,ahk_id %DefaultIMEWnd% 
    if (DetectSave <> A_DetectHiddenWindows) {
        DetectHiddenWindows,%DetectSave%
    }
    return ErrorLevel 
} 
ImmGetDefaultIMEWnd(hWnd) {
    return DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)
}
IME_Check(WinTitle) {
    WinGet,hWnd,ID,%WinTitle% 
    Return Send_ImeControl(ImmGetDefaultIMEWnd(hWnd),0x005,"")
}
IME_SetKorean() {
    if (IME_Check("A") = "0") {
        Send, {vk15sc138}
    }
}
IME_SetEnglish() {
    if (IME_Check("A") != "0") {
        Send, {vk15sc138}  
    }
}