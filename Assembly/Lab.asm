   
.MODEL FLAT,stdcall  ;������ ������ �������, �����������

.LIST ; ��������� .XLIST � .LIST ������������ ����������
      ; ������������ �������� ���������
.DATA
	a  dw  3
	b  dw  1

.DATA? ;��������� �������� ������ ������� �������������������� ������. 
	y   dw    ?

.CODE   ;��������� �������� ������ �������� ����. 
lab2:   ;��� �����, � ����� ��������� ���������� �����
	mov ax, 9	;ax=9
	imul b		;ax=9b
	mov bx, ax	;bx=9b
	mov ax,5	;ax=5
	imul a		;ax=5a
	sub bx, ax	;bx=9b-5a
	
	cmp bx, 4

	jl	m1		;9b-5a<4
	je	m2		;9b-5a=4
	jg	m3		;9b-5a>4

m1:
	;y=b^2+a^2
	mov ax, b	;ax=b
	imul b		;ax=b^2
	mov bx, ax	;bx=b^2
	mov ax, a	;ax=a
	imul a		;ax=a^2
	add bx, ax	;bx=b^2+a^2
	mov y, bx	;y=b^2+a^2
	jmp m_end
m2:
	;y=a-12
	mov ax, 12	;ax=12
	mov bx, a	;bx=a
	sub	bx, ax	;bx=a-12
	mov y, bx	;y=a-12
	jmp  m_end
m3:
	;y=|a|-3*|b|
	mov ax, a	;ax=a
	cmp ax, 0
	jl a_less
	je a_pos
	jg a_pos
a_less:
	neg ax		;ax=|a|
a_pos:
	mov bx,ax	;bx=|a|
	mov ax, b	;ax=b
	cmp ax, 0
	jl b_less
	je b_pos
	jg b_pos
b_less:
	neg ax		;ax=|b|
b_pos:
	mov si, 3	;si=3
	imul si		;ax=3*|b|
	sub bx, ax	;bx=|a|-3*|b|
	mov y, bx	;y=|a|-3*|b|

m_end:
	;mov  x,ax    ;��������� ���������� � ���� ���������� �
ret  ;��� ������, ������� �������� ������� ExitProcess, �������
	    ;���������� ���������� ������������ �������
end	lab2  ;��� ��������� ���������� - ���������� ����� �����.