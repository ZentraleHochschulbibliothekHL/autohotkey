#NoEnv
#Persistent
#SingleInstance, force

; 재사용 가능성이 높은 함수들은 라이브러리 형태로 독립적으로 관리하고 필요할때 #Include 할 것
#Include, <IME>
#Include, <WBGet_V11>
#Include, <IEGet>

^j:: ; Ctrl + J - 스크립트 실행 단축키

wb := IEGet() ; AHK 웹 브라우저 오브젝트

if (!wb) { ; IE 실행 여부 체크
    MsgBox, 16, 에러, 스크립트를 실행하기 전에 먼저 인터넷 익스플로러를 실행해야 합니다.
    return
}

; 불필요한 오류 표시를 생략하기 위해 Silent 값을 true로 설정
wb.Silent := true 

; IE 행정정보공동이용시스템으로 이동
wb.Navigate("https://www.share.go.kr") 

; 웹페이지 로딩 완료까지 대기
while wb.ReadyState != 4 || wb.document.ReadyState != "complete" || wb.Busy { 
    Sleep 10
    if (A_TickCount - initTime > 2000) {
        throw 1
    }
}

; 'e하나로민원' 바로가기 버튼 찾기 & 클릭 이벤트 호출하여 웹사이트 이동
PortalLinkBtn := wb.document.querySelector(".bbBox span.btn")
PortalLinkBtn.fireEvent("onclick")

while wb.ReadyState != 4 || wb.document.ReadyState != "complete" || wb.Busy { 
    Sleep 10
    if (A_TickCount - initTime > 2000) {
        throw 1
    }
}

MsgBox, 이동 완료

return