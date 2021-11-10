   
.MODEL FLAT,stdcall

; ���������� ������� �������������� ������ ��������� �������, ������������� �� ������ ��������.

.LIST
  
.DATA
	x		dd		2, 1, 2, 4, 2, 5, 1, 7, 3, 9
	y		dd		2, 3, 4, 5
	nx		dd		10
	ny		dd		4
	cEl		dd		0 ; ���-�� ���������� �� ������� ���������
	cElSum	dd		0 ; ����� ���������� �� ������� ���������
	const	dd		2

.DATA?
	result   dd    ? ; �������
	resultX   dd    ?
	resultY   dd    ?

.CODE 
lab3:


	mov edi, 0		; '������' �������
	lea ebx, x
	lea esi, nx
	call func

	mov eax, result

	mov cEl, 0		; ���������� �������� � �������� ������
	mov cElSum, 0
	mov edi, 0

	lea ebx, y
	lea esi, ny
	call func

	mov eax, result
	ret

func proc
	; [ebx] - ������
	; [esi] - �����
	mov eax, [esi]
	cdq
	idiv const

	mov ecx, eax	; ������� ��� ����� ���������� ������
	cmp edx, 0

	je c1			; ���� edx �� ����� ����, �� ����� ��������� ��� ���� ��������
	inc ecx
	ret
c1:
	mov eax, [ebx+edi]	; ������� ����������� ������� � ������
	cdq
	idiv const

	cmp edx, 0		; ��������� ������� �� ��������

	jne c2			; ���� ����� ��������, ���������� ���
	mov eax, [ebx+edi]
	inc cEl
	add cElSum, eax
c2:
	add edi, 8		; ������������� �������� ������� ����� ���� (������ ������ �������)
	loop c1

	cmp cEl, 0		; ��������, �� �������� �� cEl �����

	jne c3
	je c4
c3:
	mov eax, cElSum
	mov ebx, cEl
	cdq
	idiv ebx
	mov result, eax
	ret
c4:
	mov result, 0
	ret
func endp

end	lab3  