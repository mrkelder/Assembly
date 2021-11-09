   
.MODEL FLAT,stdcall

; Определить среднее арифметическое четных элементов массива, расположенных на четных позициях.

.LIST
  
.DATA
	x		dd		2, 1, 4, 4, 8, 5, 1, 7, 3, 9
	nx		dd		10
	cEl		dd		0 ; кол-во подходящих по условию елементов
	cElSum	dd		0 ; сумма подходящих по условию елементов
	const	dd		2

.DATA?
	result   dd    ?

.CODE 
lab3:
	mov edi, 0		; 'индекс' массива

	mov eax, nx
	cdq
	idiv const

	mov ecx, eax	; сколько раз будет просмотрен массив
	cmp edx, 0

	je c1			; если edx не равен нулю, то нужно прибавить еще одну итерацию
	inc ecx
c1:
					; итерация
	mov eax, x[edi]	; заносим итерируемый элемент в массив

	cdq
	idiv const

	cmp edx, 0		; проверяем элемент на четность

	jne c2			; если число нечетное, игнорируем его
	mov eax, x[edi]
	inc cEl
	add cElSum, eax
c2:
	add edi, 8		; просматриваем элементы массива через один (только четные индексы)
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
	ret
c4:
	mov result, 0
	ret

end	lab3  