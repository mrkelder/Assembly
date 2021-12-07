
.MODEL FLAT,stdcall

; В массиве найти два элемента, разность значений которых минимальна.

.LIST
  
.DATA
	;x		dd		2, 1, 2, 4, 2, 5, 1, 7, 3, 9
	x		dd		1, 2, 3
	y		dd		228, 3, 8, 5
	;nx		dd		10
	nx		dd		3
	ny		dd		4
	el1X    dd      0
	el1Y    dd      0
	el2X    dd      0
	el2Y    dd      0
	counter dd		0

.DATA?
	difX     dd     ?
	difY     dd     ?
	

.CODE 
lab3:

	push offset difX
	push offset el2X
	push offset el1X
	push nx
	push offset x
	call func

	mov eax, el1X
	mov eax, el2X

	ret

func proc
	; x/y = [ebp+8]
	; nx/ny = [ebp+12]
	; el1 = [ebp+16]
	; el2 = [ebp+20]
	; difX/difY = [ebp+24]

	push ebp
	mov ebp, esp
	push  eax			; сохраняем используемые регистры
	push  ebx
	push  ecx
	push  edi
	push  esi

	mov esi, 0			; флаг того, что минимальная разность была подсчитана
	mov edi, [ebp+8]
	mov eax, [ebp+12]
	mov counter, eax
c1:						; сравнение элемента массива с остальными элементами
	cmp counter, 0
	je c4
	mov eax, [edi]

	mov ecx, [ebp+12]	; кол-во повторений
	mov ebx, [ebp+8]	; ссылка на итерируемый элемент массива

c2:						; поиск минимальной разницы
	cmp ebx, edi		; проверяем, сравнивается ли элемент сам с собой
	je c3

	mov eax, [edi]
	sub eax, [ebx]
	cmp esi, 0
	jne m1
	mov esi, 1
	jmp m2
m1:
	cmp eax, [ebp+24]
	jg c3
m2:
	mov [ebp+24], eax	; difX/difY = eax
	mov eax, [edi]
	mov [ebp+16], eax	; el1 = [edi]
	mov eax, [ebx]
	mov [ebp+20], eax	; el2 = [ebx]
c3:
	add ebx, 4
	loop c2
	add edi, 4
	dec counter
	jmp c1
c4:

	mov eax, [ebp+24] ;dif
	mov eax, [ebp+16] ;el1
	mov eax, [ebp+20] ;el2

	mov eax, el1X
	mov eax, el2X
	mov eax, difX

	pop   esi			; восстанавливаем используемые регистры
	pop   edi
	pop   ecx
	pop   ebx
	pop   eax
	pop   ebp
	ret 20
func endp

end	lab3  