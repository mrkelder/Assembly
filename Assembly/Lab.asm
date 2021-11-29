   
.MODEL FLAT,stdcall

; Определить среднее арифметическое четных элементов массива, расположенных на четных позициях.

.LIST
  
.DATA
	x		dd		2, 1, 2, 4, 2, 5, 1, 7, 3, 9
	y		dd		4, 3, 8, 5
	nx		dd		10
	ny		dd		4
	cEl		dd		0 ; кол-во подходящих по условию елементов
	cElSum	dd		0 ; сумма подходящих по условию елементов
	const	dd		2

.DATA?
	result   dd    ?

.CODE 
lab3:

	push offset x
	push nx
	call func

	mov eax, result

	push offset y
	push ny
	call func

	mov eax, result
	ret

func proc
	mov cEl, 0
	mov cElSum, 0

	push ebp
	mov ebp, esp
	push  eax          ;сохраняем используемые регистры
	push  ebx
	push  ecx
	push  edi
	push  esi


	mov ecx, [ebp+8]
	mov ebx, [ebp+12] ; ebx - указатель на нулевой элемент массива
	shr ecx, 1
	jnc c1
	inc ecx
c1:
	mov eax, [ebx] ; eax - данный элемент итерации
	shr eax, 1
	jc c2

	mov eax, [ebx]
	inc cEl
	add cElSum, eax
c2:
	add ebx, 8		; просматриваем элементы массива через один (только четные индексы)
	loop c1

	cmp cEl, 0		; проверка, не является ли cEl нулем

	jne c3
	je c4
c3:
	mov eax, cElSum
	mov ebx, cEl
	cdq
	idiv ebx
	mov result, eax
	pop   esi         ;восстанавливаем используемые регистры
	pop   edi
	pop   ecx
	pop   ebx
	pop   eax
	pop   ebp
	ret 8
c4:
	mov result, 0
	pop   esi         ;восстанавливаем используемые регистры
	pop   edi
	pop   ecx
	pop   ebx
	pop   eax
	pop   ebp
	ret 8
func endp

end	lab3  