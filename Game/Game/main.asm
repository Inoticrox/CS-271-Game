TITLE TicTacToe (main.asm)

INCLUDE C:/Irvine/Irvine32.inc
INCLUDELIB C:/Irvine/Irvine32.lib

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode: dword

mOPrompt MACRO
	mov EDX, OFFSET oTurn
	call WriteString
	call Crlf
	mov EDX, OFFSET colPrompt
	call WriteString
	call ReadInt
	mov userCol, EAX
	mov EDX, OFFSET rowPrompt
	call WriteString
	call ReadInt
	mov userRow, EAX
ENDM

mXPrompt MACRO
	mov EDX, OFFSET xTurn
	call WriteString
	call Crlf
	mov EDX, OFFSET colPrompt
	call WriteString
	call ReadInt
	mov userCol, EAX
	mov EDX, OFFSET rowPrompt
	call WriteString
	call ReadInt
	mov userRow, EAX
ENDM

mWriteStr MACRO input
	push EDX,
	mov EDX, OFFSET input
	call WriteString
	pop EDX
ENDM

XTurn
	mXPrompt


XTurn ENDP

OTurn PROC
	mOPrompt


OTurn ENDP


.data
	board DWORD 5 DUP(5 DUP(?))
	xTurn BYTE "It's X's turn.",0
	oTurn BYTE "It's O's turn.",0
	colPrompt BYTE "Enter an empty column number: ",0
	rowPrompt BYTE "Enter an empty row number: ",0
	userCol DWORD ?
	userRow DWORD ?

.code
main proc
	



	invoke ExitProcess, 0
main endp
end main