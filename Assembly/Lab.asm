   
.MODEL FLAT,stdcall

; ���������� ������� �������������� ������ ��������� �������, ������������� �� ������ ��������.

.LIST
  
.DATA
	x		dd		2, 1, 4, 4, 8, 5, 1, 7, 3, 9
	nx		dd		10
	cEl		dd		0 ; ���-�� ���������� �� ������� ���������
	cElSum	dd		0 ; ����� ���������� �� ������� ���������
	const	dd		2

.DATA?
	result   dd    ?

.CODE 
lab3:
	mov edi, 0		; '������' �������

	mov eax, nx
	cdq
	idiv const

	mov ecx, eax	; ������� ��� ����� ���������� ������
	cmp edx, 0

	je c1			; ���� edx �� ����� ����, �� ����� ��������� ��� ���� ��������
	inc ecx
c1:
					; ��������
	mov eax, x[edi]	; ������� ����������� ������� � ������

	cdq
	idiv const

	cmp edx, 0		; ��������� ������� �� ��������

	jne c2			; ���� ����� ��������, ���������� ���
	mov eax, x[edi]
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

end	lab3  