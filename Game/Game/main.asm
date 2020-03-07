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

ENDM

;fills rows with inputs 
mEvenRows MACRO	spaceOne, spaceTwo, spaceThree, row

	mov board + (row * 5) , spaceOne
	mov board + 1 + (row * 5), 124
	mov board + 2 + (row * 5), spaceTwo
	mov board + 3 + (row * 5), 124
	mov board + 4 + (row * 5), spaceThree		

ENDM

mOddRows MACRO row

	mov board + (row * 5), 95
	mov board + 1 + (row * 5), 95
	mov board + 2 + (row * 5), 95
	mov board + 3 + (row * 5), 95
	mov board + 4 + (row * 5), 95

ENDM

;this should fill the board matrix with the empty board. 
mMake_Board MACRO

	mEvenRows 32, 32, 32, 0
	mOddRows 1
	mEvenRows 32, 32, 32, 2
	mOddRows 3
	mEvenRows 32, 32, 32, 4
	
ENDM

mPrintRow MACRO	row

	mPrint_indice 0, (row * 5)
	mPrint_indice 1, (row * 5)
	mPrint_indice 2, (row * 5)
	mPrint_indice 3, (row * 5)
	mPrint_indice 4, (row * 5)

ENDM

;prints board with row/col numbers
mPrint_Board MACRO

	mWriteStr cols

	mWriteStr rowOne
	mPrintRow 0
	call Crlf

	mWriteStr space
	mPrintRow 1
	call Crlf

	mWriteStr rowTwo
	mPrintRow 2
	call Crlf

	mWriteStr space
	mPrintRow 3
	call Crlf
	
	mWriteStr rowThree
	mPrintRow 4
	
	call Crlf

ENDM

mPrint_indice MACRO col, row 

	mov AL, board + col + row
	call WriteChar

ENDM

mPrint_data_indice MACRO indice				;	this prints a single indice from the data array 

	mov AL, data + indice
	call WriteChar

ENDM

;a single move, places an X or O
mPlayer_turn MACRO row, col, X_O

	LOCAL O
	LOCAL X
	LOCAL done

	mov EAX, 0

	cmp EAX, X_O
	je O

X:
	mov board + ( row * 5 ) + col, 88
	
	jmp done
O:
	mov board + ( row * 5 ) + col, 79

done:

ENDM

mFill_data MACRO							;	hardcoding the data from board into the data array FML

	mov al, board + 0
	mov data, al

	mov al, board + 2
	mov data + 1, al

	mov al, board + 4
	mov data + 2, al

	mov al, board + 10
	mov data + 3, al

	mov al, board + 12
	mov data + 4, al

	mov al, board + 14
	mov data + 5, al

	mov al, board + 20
	mov data + 6, al

	mov al, board + 22
	mov data + 7, al

	mov al, board + 24
	mov data + 8, al

ENDM 

mPrint_data MACRO					;	prints the data array 

	mPrint_data_indice 0
	mPrint_data_indice 1
	mPrint_data_indice 2
	mPrint_data_indice 3
	mPrint_data_indice 4
	mPrint_data_indice 5
	mPrint_data_indice 6
	mPrint_data_indice 7
	mPrint_data_indice 8

ENDM

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

;Inserts an X depending on where user requested
mXInserts
	cmp userRow, 1
	je pickRow1

	cmp userRow, 2
	je pickRow2

	cmp userRow, 3
	je pickRow 3

pickRow1:
	jmp row1
pickRow2:
	jmp row2
pickRow3:
	jmp row3

row1:
	cmp userCol, 1
	je pickCol1

	cmp userCol, 2
	je pickCol2

	cmp userCol, 3
	je pickCol3

pickCol1:
	mPlayer_turn 0,0,1
pickCol2:
	mPlayer_turn 0,2,1
pickCol3:
	mPlayer_turn 0,4,1

row2:
	cmp userCol, 1
	je pickCol1

	cmp userCol, 2
	je pickCol2

	cmp userCol, 3
	je pickCol3

pickCol1:
	mPlayer_turn 2,0,1
pickCol2:
	mPlayer_turn 2,2,1
pickCol3:
	mPlayer_turn 2,4,1


row3:
	cmp userCol, 1
	je pickCol1

	cmp userCol, 2
	je pickCol2

	cmp userCol, 3
	je pickCol3

pickCol1:
	mPlayer_turn 4,0,1
pickCol2:
	mPlayer_turn 4,2,1
pickCol3:
	mPlayer_turn 4,4,1

ENDM

;Inserts an O depending on where user requested
mOInserts
;First it compares the row against 1 2 3 
	cmp userRow, 1
	je pickRow1

	cmp userRow, 2
	je pickRow2

	cmp userRow, 3
	je pickRow 3

pickRow1:
	jmp row1
pickRow2:
	jmp row2
pickRow3:
	jmp row3

;Then based on the row it jumps to row1, row2, row3
row1:
;Then checks the column and jumps to the proper placement
	cmp userCol, 1
	je pickCol1

	cmp userCol, 2
	je pickCol2

	cmp userCol, 3
	je pickCol3

pickCol1:
	mPlayer_turn 0,0,0
pickCol2:
	mPlayer_turn 0,2,0
pickCol3:
	mPlayer_turn 0,4,0

row2:
	cmp userCol, 1
	je pickCol1

	cmp userCol, 2
	je pickCol2

	cmp userCol, 3
	je pickCol3

pickCol1:
	mPlayer_turn 2,0,0
pickCol2:
	mPlayer_turn 2,2,0
pickCol3:
	mPlayer_turn 2,4,0


row3:
	cmp userCol, 1
	je pickCol1

	cmp userCol, 2
	je pickCol2

	cmp userCol, 3
	je pickCol3

pickCol1:
	mPlayer_turn 4,0,0
pickCol2:
	mPlayer_turn 4,2,0
pickCol3:
	mPlayer_turn 4,4,0

ENDM


mWriteStr MACRO input
	push EDX
	mov EDX, OFFSET input
	call WriteString
	pop EDX
ENDM

.data
	board		BYTE	5 DUP(5 DUP(?))
	data		BYTE	9 DUP (?)
	cols		BYTE	"   1 2 3", 10, 0
	rowOne		BYTE	" 1 ", 0
	rowTwo		BYTE	" 2 ", 0
	rowThree	BYTE	" 3 ", 0
	space		BYTE	"   ", 0
	xTurn		BYTE	"It's X's turn.",0
	oTurn		BYTE	"It's O's turn.",0
	colPrompt	BYTE	"Enter an empty column number: ",0
	rowPrompt	BYTE	"Enter an empty row number: ",0
	colError	BYTE	"Invalid column entry. Please enter a valid column number: ",0
	rowError	BYTE	"Invalid row entry. Please enter a valid row number: ",0
	userCol		DWORD	? 
	userRow		DWORD	? 
	xChar		BYTE	"X",0
	oChar		BYTE	"O",0
	works		BYTE	"Works!",0

.code
main proc
	
	mMake_board

	mPrint_Board

	mPlayer_turn 0,0,0
	mPrint_Board

	;mPlayer_turn 4,0,1
	;mPrint_Board

	mFill_data
	mPrint_data

	invoke ExitProcess, 0
main endp

strtXTurn PROC
	mXPrompt
	
	mPlayer_turn userRow,userCol,1
	mPrint_Board
	;checks win condition
	ret
strtXTurn ENDP

strtOTurn PROC
	mOPrompt
	
	;mPlayer_turn userRow,userCol,0
	;mPrint_Board
	;checks win condition
	ret
strtOTurn ENDP

end main