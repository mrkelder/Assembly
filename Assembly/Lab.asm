   
.MODEL FLAT,stdcall  ;Модель памяти плоская, стандартный

;   Условие задачи,используем формат байта
;       / b^2+a^2  , если 9b-5a<4;   a=4,   b=1,  y=17	(-11<4)
;    Y=|  a-12     , если 9b-5a=4;   a=1,	b=1,  y=-11	(4=4)
;       \ |a|-3*|b|, если 9b-5a>4;   a=-5,  b=-2, y=-1	(7>4)

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA
	a  db  1
	b  db  1

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	y   db    ?

.CODE   ;Директива описания начала сегмента кода. 
lab2:   ;Это метка, в нашей программе определяет точку
	mov al, 9	;al=9
	imul b		;al=9b
	mov bl, al	;bl=9b
	mov al,5	;al=5
	imul a		;al=5a
	sub bl, al	;bl=9b-5a
	
	cmp bl, 4

	jl	m1		;9b-5a<4
	je	m2		;9b-5a=4
	jg	m3		;9b-5a>4

m1:
	;y=b^2+a^2
	mov al, b	;al=b
	imul b		;al=b^2
	mov bl, al	;bl=b^2
	mov al, a	;al=a
	imul a		;al=a^2
	add bl, al	;bl=b^2+a^2
	mov y, bl	;y=b^2+a^2
	jmp m_end
m2:
	;y=a-12
	mov al, 12	;al=12
	mov bl, a	;bl=a
	sub	bl, al	;bl=a-12
	mov y, bl	;y=a-12
	jmp  m_end
m3:
	;y=|a|-3*|b|
	mov al, a	;al=a
	cmp al, 0
	jl a_less
	je a_pos
	jg a_pos
a_less:
	neg al		;al=|a|
a_pos:
	mov bl,al	;bl=|a|
	mov al, b	;al=b
	cmp al, 0
	jl b_less
	je b_pos
	jg b_pos
b_less:
	neg al		;al=|b|
b_pos:
	mov cl, 3	;cl=3
	imul cl		;al=3*|b|
	sub bl, bl	;bl=|a|-3*|b|
	mov y, bl	;y=|a|-3*|b|

m_end:

ret 

end	lab2  