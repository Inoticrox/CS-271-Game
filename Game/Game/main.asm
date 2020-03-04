TITLE TicTacToe (main.asm)

INCLUDE C:/Irvine/Irvine32.inc
INCLUDELIB C:/Irvine/Irvine32.lib

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode: dword

MAX_SIZE = 25

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

	;Checks for valid column input
colCheck:
	;Checks for non-numbers and negatives
	cmp EAX, 0
	jle colWrong

	;Checks for values larger than number of columns
	cmp EAX, 3
	jg colWrong

	jmp colRight

colWrong:
	;Reprompts then checks again
	mWriteStr colError
	call Readint
	jmp colCheck

colRight:
	mov userCol, EAX

	;Prompts for a row
	mov EDX, OFFSET rowPrompt
	call WriteString

	;Sets inputted row to userRow variable
	call ReadInt

	;Checks for valid row input
rowCheck:
	;Checks for non-numbers and negatives
	cmp EAX, 0
	jle rowWrong

	;Checks for values larger than number of rows
	cmp EAX, 3
	jg rowWrong

	jmp rowRight

rowWrong:
	;Reprompts then checks again
	mWriteStr rowError
	call Readint
	jmp rowCheck

rowRight:
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

	;Checks for valid column input
colCheck:
	;Checks for non-numbers and negatives
	cmp EAX, 0
	jle colWrong

	;Checks for values larger than number of columns
	cmp EAX, 3
	jg colWrong

	jmp colRight

colWrong:
	;Reprompts then checks again
	mWriteStr colError
	call Readint
	jmp colCheck

colRight:
	mov userCol, EAX

	;Prompts for a row
	mov EDX, OFFSET rowPrompt
	call WriteString

	;Sets inputted row to userRow variable
	call ReadInt

	;Checks for valid row input
rowCheck:
	;Checks for non-numbers and negatives
	cmp EAX, 0
	jle rowWrong

	;Checks for values larger than number of rows
	cmp EAX, 3
	jg rowWrong

	jmp rowRight

rowWrong:
	;Reprompts then checks again
	mWriteStr rowError
	call Readint
	jmp rowCheck

rowRight:
	mov userRow, EAX

ENDM


mWriteStr MACRO input
	push EDX
	mov EDX, OFFSET input
	call WriteString
	pop EDX
ENDM



.data
	board BYTE 5 DUP(5 DUP(?))
	xTurn BYTE "It's X's turn.",0
	oTurn BYTE "It's O's turn.",0
	colPrompt BYTE "Enter an empty column number: ",0
	rowPrompt BYTE "Enter an empty row number: ",0
	colError BYTE "Invalid column entry. Please enter a valid column number: ",0
	rowError BYTE "Invalid row entry. Please enter a valid row number: ",0
	userCol DWORD ? 
	userRow DWORD ? 
	xChar BYTE "X",0
	oChar BYTE "O",0
	works BYTE "Works!",0

.code
main proc
	
	call strtXTurn

	invoke ExitProcess, 0
main endp

strtXTurn PROC
	mXPrompt
	;mov board[userCol][userRow], xChar
	;prints board
	;checks win condition
	ret
strtXTurn ENDP

strtOTurn PROC
	mOPrompt
	;mov board[userCol][userRow], oChar
	;prints board
	;checks win condition
	ret
strtOTurn ENDP

end main