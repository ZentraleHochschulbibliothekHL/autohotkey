#NoEnv
#Persistent
#SingleInstance, force

; ���� ���ɼ��� ���� �Լ����� ���̺귯�� ���·� ���������� �����ϰ� �ʿ��Ҷ� #Include �� ��
#Include, <IME>
#Include, <WBGet_V11>
#Include, <IEGet>

^j:: ; Ctrl + J - ��ũ��Ʈ ���� ����Ű

wb := IEGet() ; AHK �� ������ ������Ʈ

if (!wb) { ; IE ���� ���� üũ
    MsgBox, 16, ����, ��ũ��Ʈ�� �����ϱ� ���� ���� ���ͳ� �ͽ��÷η��� �����ؾ� �մϴ�.
    return
}

; ���ʿ��� ���� ǥ�ø� �����ϱ� ���� Silent ���� true�� ����
wb.Silent := true 

; IE �������������̿�ý������� �̵�
wb.Navigate("https://www.share.go.kr") 

; �������� �ε� �Ϸ���� ���
while wb.ReadyState != 4 || wb.document.ReadyState != "complete" || wb.Busy { 
    Sleep 10
    if (A_TickCount - initTime > 2000) {
        throw 1
    }
}

; 'e�ϳ��ιο�' �ٷΰ��� ��ư ã�� & Ŭ�� �̺�Ʈ ȣ���Ͽ� ������Ʈ �̵�
PortalLinkBtn := wb.document.querySelector(".bbBox span.btn")
PortalLinkBtn.fireEvent("onclick")

while wb.ReadyState != 4 || wb.document.ReadyState != "complete" || wb.Busy { 
    Sleep 10
    if (A_TickCount - initTime > 2000) {
        throw 1
    }
}

MsgBox, �̵� �Ϸ�

return