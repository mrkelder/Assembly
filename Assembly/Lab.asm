   
.MODEL FLAT,stdcall  ;Модель памяти плоская, стандартный

;   Условие задачи,используем формат байта
;       / b^2+a^2  , если 9b-5a<4;   a=4,   b=1,  y=17	(-11<4)
;    Y=|  a-12     , если 9b-5a=4;   a=1,	b=1,  y=-11	(4=4)
;       \ |a|-3*|b|, если 9b-5a>4;   a=-5,  b=-2, y=-1	(7>4)

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA
	a  db  4
	b  db  1

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	y   db    ?

.CODE   ;Директива описания начала сегмента кода. 
lab2:   ;Это метка, в нашей программе определяет точку
	mov ah, 9	;ax=9
	imul b		;ax=9b
	mov bh, ah	;bx=9b
	mov ah,5	;ax=5
	imul a		;ax=5a
	sub bh, ah	;bx=9b-5a
	
	cmp bh, 4

	jl	m1		;9b-5a<4
	je	m2		;9b-5a=4
	jg	m3		;9b-5a>4

m1:
	;y=b^2+a^2
	mov bh, b	;ax=b
	imul b		;ax=b^2
	mov bh, ah	;bx=b^2
	mov ah, a	;ax=a
	imul a		;ax=a^2
	add bh, ah	;bx=b^2+a^2
	mov y, bh	;y=b^2+a^2
	jmp m_end
m2:
	;y=a-12
	mov ah, 12	;ax=12
	mov bh, a	;bx=a
	sub	bh, ah	;bx=a-12
	mov y, bh	;y=a-12
	jmp  m_end
m3:
	;y=|a|-3*|b|
	mov ah, a	;ax=a
	cmp ah, 0
	jl a_less
	je a_pos
	jg a_pos
a_less:
	neg ah		;ax=|a|
a_pos:
	mov bh,ah	;bx=|a|
	mov ah, b	;ax=b
	cmp ah, 0
	jl b_less
	je b_pos
	jg b_pos
b_less:
	neg ah		;ax=|b|
b_pos:
	mov ch, 3	;si=3
	imul ch		;ax=3*|b|
	sub bh, bh	;bx=|a|-3*|b|
	mov y, bh	;y=|a|-3*|b|

m_end:
	;mov  x,ax    ;Занесение результата в поле переменной Х
ret  ;это макрос, который вызывает функцию ExitProcess, которая
	    ;возвращает управление операционоой системе
end	lab2  ;Это директива ассемблера - определяет точку входа.