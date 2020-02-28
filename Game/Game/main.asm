TITLE TicTacToe (main.asm)

INCLUDE C:/Irvine/Irvine32.inc
INCLUDELIB C:/Irvine/Irvine32.lib

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode: dword

mOPrompt MACRO
	;States it's O's turn
	mov EDX, OFFSET oTurn
	call WriteString
	call Crlf

	;Prompts for a column
	mov EDX, OFFSET colPrompt
	call WriteString

	;Sets inputted column to userCol variable
	call ReadInt
	mov userCol, EAX

	;Prompts for a row
	mov EDX, OFFSET rowPrompt
	call WriteString

	;Sets inputted row to userRow variable
	call ReadInt
	mov userRow, EAX
ENDM

mXPrompt MACRO
	;States it's X's turn
	mov EDX, OFFSET xTurn
	call WriteString
	call Crlf

	;Prompts for a column
	mov EDX, OFFSET colPrompt
	call WriteString

	;Sets inputted column to userCol variable
	call ReadInt
	mov userCol, EAX

	;Prompts for a row
	mov EDX, OFFSET rowPrompt
	call WriteString

	;Sets inputted row to userRow variable
	call ReadInt
	mov userRow, EAX
ENDM

mWinCheckXCol MACRO

	mov ESI, 0
	;ECX is outer loop counter
	mov ECX, 0
outerLoop:
	cmp ECX, 5
	je done
	;EBX is inner loop counter
	mov EBX, 0

innerLoop:
	mov EDX, OFFSET xChar
	;This isn't working, do a write in for each ECX and EBX to see if it isn't accessing the right indexes
	mov EAX, board[ECX][EBX]
	cmp EAX, EDX
	je iEqual
	jmp innerLoopDone

iEqual:
	mWriteStr works
	call Crlf
	inc ESI
	cmp ESI, 3
	je done
	cmp EBX, 5
	je innerLoopDone
	inc EBX
	
	jmp innerLoop

innerLoopDone:
	inc ECX
	jmp outerLoop

done:

ENDM

mWriteStr MACRO input
	push EDX
	mov EDX, OFFSET input
	call WriteString
	pop EDX
ENDM

;XTurn PROC
	;mXPrompt
	;mov board[userCol][userRow], xChar
	;prints board
	;checks win condition

;XTurn ENDP

;OTurn PROC
	;mOPrompt
	;mov board[userCol][userRow], oChar
	;prints board
	;checks win condition

;OTurn ENDP


.data
	board DWORD 5 DUP(5 DUP(?))
	xTurn BYTE "It's X's turn.",0
	oTurn BYTE "It's O's turn.",0
	colPrompt BYTE "Enter an empty column number: ",0
	rowPrompt BYTE "Enter an empty row number: ",0
	userCol DWORD ? 
	userRow DWORD ? 
	xChar BYTE "X",0
	oChar BYTE "O",0
	works BYTE "Works!",0

.code
main proc
	
	mov EDX, OFFSET xChar
	mov board[0][1], EDX
	mov board[0][2], EDX
	mov board[0][3], EDX

	mWinCheckXCol

	invoke ExitProcess, 0
main endp
end main