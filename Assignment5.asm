
comment !-------------------------------------------------------------------------------------

	5/28/2020

	Clears the screen, locates the cursor near the middle of the screen.
    Prompts the user for two signed integers.
    Displays their sum and difference.
    Repeats the same steps three times. Clears the screen after each loop iteration.

---------------------------------------------------------------------------------------------!

INCLUDE Irvine32.inc

.data

ints dword 2 dup (?)
direction byte "Enter two integers!", 0
prompts byte "Integer: ", 0
sumString byte "Sum: ", 0
diffString byte "Difference: ", 0
pressKey byte "Press any key ...", 0
counter byte " more times", 0
container dword ?
point byte ?, ?


.code
main PROC
		
	mov ecx, 3
	L2:
		mov point, 10
		mov [point + 1], 50
		call locate
		mov edx, offset direction
		call writeString
		mov container, ecx
		mov ecx, lengthof ints
		mov ebx, 0
		mov esi, offset ints
		call crlf

		L1:
			call input
			mov [esi + ebx], eax
			add ebx, 4
		loop L1

		call displaySum
		call displayDifference
		inc [point]
		call locate
		mov ecx, container
		dec container
		mov eax, container
		call writeDec
		mov edx, offset counter
		call writeString
		call waitForKey
	loop L2

exit
main ENDP



;---------------------------------------------------------
; locate PROC

; sets cursor to center of the screen
; recieves: edx for gotoxy procedure
; returns: new cursor position in x/y
; requirements: none
;---------------------------------------------------------

locate PROC
	mov dh, point
	mov dl, point + 1
	call Gotoxy
	ret
locate ENDP



;---------------------------------------------------------
; input PROC

; prompts user input integer
; recieves: eax
; returns: input = eax
; requirements: none
;---------------------------------------------------------

input PROC
	inc [point]
	call locate
	mov edx, offset prompts
	call writeString
	call readInt
	ret
input ENDP



;---------------------------------------------------------
; displaySum PROC

; calculates and displays sum of 2 values in ints array
; recieves: eax for address and ebx for sum
; returns: eax = sum
; requirements: assigned values in its array
;---------------------------------------------------------

displaySum PROC
	inc [point]
	call locate
	mov edx, offset sumString
	call writeString
	mov eax, offset ints
	mov ebx, [eax]
	add ebx, [eax + 4]
	mov eax, ebx
	call writeInt
	ret
displaySum ENDP



;---------------------------------------------------------
; displayDifference PROC

; calculates and displays difference of 2 values in ints array
; recieves: eax for address and ebx for sum
; returns: eax = difference
; requirements: assigned values in its array
;---------------------------------------------------------

displayDifference PROC
	inc [point]
	call locate
	mov edx, offset diffString
	call writeString
	mov eax, offset ints
	mov ebx, [eax]
	sub ebx, [eax + 4]
	mov eax, ebx
	call writeInt
	ret
displayDifference ENDP



;---------------------------------------------------------
; waitForkey PROC

; promps user to press key to continue
; recieves: nothing
; returns: prompt to enter key
; requirements: none
;---------------------------------------------------------

waitForKey PROC
	inc [point]
	call locate
	mov edx, offset pressKey
	call writeString
	call readChar
	call ClrScr
	ret
waitForKey ENDP

END main



comment !---------------------------

    Enter two integers!
    Integer: 3
    Integer: 5
    Sum: +8
    Difference: -2
    2 more times
    Press any key ...

-----------------------------------!