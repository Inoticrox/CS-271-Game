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

	mov winCond, 1
	mEvenRows 32, 32, 32, 0
	mOddRows 1
	mEvenRows 32, 32, 32, 2
	mOddRows 3
	mEvenRows 32, 32, 32, 4
	
ENDM

;prints out the rows
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

;Prints a single indice of a column and row
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
	LOCAL colCheck
	LOCAL colWrong
	LOCAL colRight
	LOCAL rowCheck
	LOCAL rowWrong
	LOCAL rowRight
	
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
	LOCAL colCheck
	LOCAL colWrong
	LOCAL colRight
	LOCAL rowCheck
	LOCAL rowWrong
	LOCAL rowRight

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

;Write String macro for ease of use
mWriteStr MACRO input
	push EDX
	mov EDX, OFFSET input
	call WriteString
	pop EDX
ENDM

mRowcheck MACRO	row, x_o					;	checks if a single row has been won 
	
	LOCAL colOne
	LOCAL colTwo
	LOCAL colThree
	LOCAL win
	LOCAL ending

	mov al, x_o

	colOne:
		cmp al, data + (row * 3) + 0
		je colTwo
		jmp ending

	colTwo:
		cmp al, data + (row * 3) + 1
		je colThree
		jmp ending


	colThree:
		cmp al, data + (row * 3) + 2
		je win
		jmp ending


	win:
		mov winCond, 0
		mov winplayer, x_o
		mPrintWinMessage

	ending:


ENDM

mcheckRows_all MACRO						;	checks all of the rows for the win cond

	mRowcheck 0, 88						;	checks all rows for X
	mRowcheck 1, 88
	mRowcheck 2, 88


	mRowcheck 0, 79						;	checks all rows for O
	mRowcheck 1, 79
	mRowcheck 2, 79


ENDM

; Checks if a single column has won
mcolCheck MACRO col, x_o

	LOCAL rowOne
	LOCAL rowTwo
	LOCAL rowThree
	LOCAL win
	LOCAL ending


	mov al, x_o


	rowOne:
		cmp al, data + col
		je rowTwo
		jmp ending

	rowTwo:
		cmp al, data + col + 3
		je rowThree
		jmp ending


	rowThree:
		cmp al, data + col + 6
		je win
		jmp ending


	win:
	mov winCond, 0
	mov winplayer, x_o
	mPrintWinMessage

	ending:


ENDM

;Checks all columns for win condition
mcheckCols_all MACRO

	
	mcolCheck 0, 79		; Checks all columns for X
	mcolCheck 1, 79
	mcolCheck 2, 79

	mcolCheck 0, 88		; Checks all columns for O
	mcolCheck 1, 88
	mcolCheck 2, 88


ENDM

;Checks the diagonal directions for win condition by specific spots on the board based on an X or O input
mCheckDiag MACRO x_o
	
	LOCAL ending
	LOCAL win
	LOCAL spotOne
	LOCAL spotTwo 
	LOCAL spotThree
	LOCAL spotFour
	LOCAL spotFive

	mov al, x_o


	spotOne: 
		cmp al, data
		je spotTwo
		jmp ending

	spotTwo: 
		cmp al, data + 4
		je spotThree
		jmp ending

	spotThree: 
		cmp al, data + 8
		je win
		jmp ending

	spotFour:
		cmp al, data + 2
		je spotFive
		jmp ending 

	spotFive: 
		cmp al, data + 6 
		je win
		jmp ending 

	win: 
		mov winCond, 0
		mov winplayer, x_o 
		mPrintWinMessage

	ending: 

ENDM

;Checks both X and O for the diagonal spots
mcheckDiag_both MACRO

	mcheckDiag 79
	mcheckDiag 88

ENDM

;Checks to see if the entire data array is full and no other win condition has been checked
mTiecheck MACRO 
	
	LOCAL ending

	mov al, " "
	cmp al, data
	je ending

	cmp al, data + 1
	je ending

	cmp al, data + 2
	je ending

	cmp al, data + 3
	je ending

	cmp al, data + 4
	je ending

	cmp al, data + 5
	je ending

	cmp al, data + 6
	je ending

	cmp al, data + 7
	je ending

	cmp al, data + 8
	je ending

	mov winCond, 2
	mPrintWinMessage
ending:

ENDM

;Prints out the welcome and program message
mIntro MACRO
	mWriteStr welcome
	mWriteStr progby

ENDM

;Prints out a win message depending on which player won or if it was a tie
mPrintWinMessage MACRO
	
	LOCAL xWins
	LOCAL oWins
	LOCAL tieWins
	LOCAL done

	cmp winCond, 2
	je tieWins
	cmp winplayer, 88
	je xWins
	cmp winplayer, 79
	je oWins

xWins:
	mWriteStr xWin
	jmp done
	
oWins:
	mWriteStr oWin
	jmp done

tieWins:
	mWriteStr tieWin

done:

ENDM

mEmptyCheck MACRO row, col
	
	LOCAL notEqual
	LOCAL ending

	mov al, " "
	cmp al, data + ( (userRow - 1) * 3 ) + (userCol - 1)
	je ending
	
	mWriteStr error1

ending:
	
ENDM

.data
	board		BYTE	5 DUP(5 DUP(?))
	data		BYTE	9 DUP (?)
	cols		BYTE	"   1 2 3", 10, 0
	rowOne		BYTE	" 1 ", 0
	rowTwo		BYTE	" 2 ", 0
	rowThree	BYTE	" 3 ", 0
	space		BYTE	"   ", 0
	xTurn		BYTE	"It's X's turn.", 0
	oTurn		BYTE	"It's O's turn.", 0
	xWin		BYTE	"Player X Wins!",0
	oWin		BYTE	"Player O Wins!",0
	tieWin		BYTE	"It's a tie!",0
	colPrompt	BYTE	"Enter an empty column number: ", 0
	rowPrompt	BYTE	"Enter an empty row number: ", 0
	colError	BYTE	"Invalid column entry. Please enter a valid column number: ",0
	rowError	BYTE	"Invalid row entry. Please enter a valid row number: ",0
	error1		BYTE	"Invalid entry, please enter again.",0
	welcome		BYTE	" Welcome to tic tac toe!", 10, 0
	progby		BYTE	" Programmed by Hugh MacWilliams and Michael Carris Jr. ", 10, 0



	xStarts		DWORD	0
	oStarts		DWORD	0
	userCol		DWORD	? 
	userRow		DWORD	? 
	whosTurn	DWORD	?
	winCond		DWORD	1
	winplayer	BYTE	?
	xChar		BYTE	"X",0
	oChar		BYTE	"O",0
	works		BYTE	"Works!",0

.code
main proc
	
	mIntro
	
	mMake_board
	mPrint_Board

	call gamePlay

	invoke ExitProcess, 0
main endp

;Starts X's turn by calling for user input on the board, printing the board, filling out the data, and then checking the win condition
strtXTurn PROC
	mov whosTurn, 0
	mXPrompt
	
	call XInserts
	mPrint_Board
	mFill_data
	call winCheck

	ret
strtXTurn ENDP

;Starts O's turn by calling for user input on the board, printing the board, filling out the data, and then checking the win condition
strtOTurn PROC
	mov whosTurn, 1
	mOPrompt
	
	call OInserts
	mPrint_Board
	mFill_data
	call winCheck

	ret
strtOTurn ENDP

;Inserts an O depending on where user requested
OInserts PROC
;First it compares the row entered against 1, 2, 3 

;Checks if user's row and column is empty
	;call emptyCheck

	cmp userRow, 1
	je pickRow1

	cmp userRow, 2
	je pickRow2

	cmp userRow, 3
	je pickRow3

;Then based on the row it jumps to row1, row2, row3
pickRow1:
	jmp row1
pickRow2:
	jmp row2
pickRow3:
	jmp row3

row1:
;Then checks the column and jumps to the proper placement
	cmp userCol, 1
	je pickCol1

	cmp userCol, 2
	je pickCol2

	cmp userCol, 3
	je pickCol3

;Column 1, Row 1
pickCol1:
	mPlayer_turn 0,0,0
	jmp done

;Column 2, Row 1
pickCol2:
	mPlayer_turn 0,2,0
	jmp done

;Column 3, Row 1
pickCol3:
	mPlayer_turn 0,4,0
	jmp done

row2:
	cmp userCol, 1
	je pickCol12

	cmp userCol, 2
	je pickCol22

	cmp userCol, 3
	je pickCol32

;Column 1, Row 2
pickCol12:
	mPlayer_turn 2,0,0
	jmp done

;Column 2, Row 2
pickCol22:
	mPlayer_turn 2,2,0
	jmp done

;Column 3, Row 2
pickCol32:
	mPlayer_turn 2,4,0
	jmp done

row3:
	cmp userCol, 1
	je pickCol13

	cmp userCol, 2
	je pickCol23

	cmp userCol, 3
	je pickCol33

;Column 1, Row 3
pickCol13:
	mPlayer_turn 4,0,0
	jmp done

;Column 2, Row 3
pickCol23:
	mPlayer_turn 4,2,0
	jmp done

;Column 3, Row 3
pickCol33:
	mPlayer_turn 4,4,0
	jmp done

done:

ret
OInserts ENDP

;Inserts an X depending on where user requested
XInserts PROC
;First it compares the row entered against 1, 2, 3 

;Checks if user's row and column is empty
	;call emptyCheck

	cmp userRow, 1
	je pickRow1

	cmp userRow, 2
	je pickRow2

	cmp userRow, 3
	je pickRow3

;Then based on the row it jumps to row1, row2, row3
pickRow1:
	jmp row1
pickRow2:
	jmp row2
pickRow3:
	jmp row3

row1:
;Then checks the column and jumps to the proper placement
	cmp userCol, 1
	je pickCol1

	cmp userCol, 2
	je pickCol2

	cmp userCol, 3
	je pickCol3

;Column 1, Row 1
pickCol1:
	mPlayer_turn 0,0,1
	jmp done

;Column 2, Row 1
pickCol2:
	mPlayer_turn 0,2,1
	jmp done

;Column 3, Row 1
pickCol3:
	mPlayer_turn 0,4,1
	jmp done

row2:
	cmp userCol, 1
	je pickCol12

	cmp userCol, 2
	je pickCol22

	cmp userCol, 3
	je pickCol32

;Column 1, Row 2
pickCol12:
	mPlayer_turn 2,0,1
	jmp done

;Column 2, Row 2
pickCol22:
	mPlayer_turn 2,2,1
	jmp done

;Column 3, Row 2
pickCol32:
	mPlayer_turn 2,4,1
	jmp done

row3:
	cmp userCol, 1
	je pickCol13

	cmp userCol, 2
	je pickCol23

	cmp userCol, 3
	je pickCol33

;Column 1, Row 3
pickCol13:
	mPlayer_turn 4,0,1
	jmp done

;Column 2, Row 3
pickCol23:
	mPlayer_turn 4,2,1
	jmp done

;Column 3, Row 3
pickCol33:
	mPlayer_turn 4,4,1
	jmp done

done:

ret
XInserts ENDP

;Random turn procedure which picks either 1 or 2 randomly and then calls the x or o start turn procedure
randomTurn PROC
	call Randomize
	mov oStarts, 0
	mov xStarts, 0
	
	mov EAX, 2
	call RandomRange
	add EAX, 1
	
	cmp EAX, 1
	je xPlayer
	cmp EAX, 2
	je oPlayer
	jmp done

xPlayer:
	mov xStarts, 1
	call strtXTurn
	jmp done
oPlayer:
	mov oStarts, 1
	call strtOTurn
	jmp done
done:
	ret
randomTurn ENDP

;Runs all the win condition chekcing macros
;Checks Rows, then Columns, then Diagional positions, finally it checks if there is a tie on the board
winCheck PROC

	mCheckRows_all
	mcheckCols_all
	mcheckDiag_both
	mTiecheck

	ret
winCheck ENDP

;The main gameplay procedure
;Runs the random turn first, then has 2 loops based on which player started first
;Calls the next players turn then continues to alternate turns, checking if a player has won after each turn
gamePlay PROC
	
	call randomTurn
	cmp xStarts, 1
	je gameloop1
	cmp oStarts, 1
	je gameloop2
	jmp done

;If X started first
gameloop1:
	call strtOTurn
	cmp winCond, 0
	je done
	cmp winCond, 2
	je done

	call strtXTurn
	cmp winCond, 0
	je done
	cmp winCond, 2
	je done

	loop gameloop1
	jmp done

;If O started first
gameloop2:
	call strtXTurn
	cmp winCond, 0
	je done
	cmp winCond, 2
	je done
	
	call strtOTurn
	cmp winCond, 0
	je done
	cmp winCond, 2
	je done

	loop gameloop2

done:

	ret

gamePlay ENDP

;!!!!!DOES NOT FUNCTION PROPERLY!!!!!
COMMENT @
;It should compare the user's specified position to a " " and then error if it's not a space.
;It does not, instead it won't allow you to enter anything in at all

;Checks if user's row and column is empty
emptyCheck PROC
;First it compares the row entered against 1, 2, 3 
	mov al, " "
start:

	cmp userRow, 1
	je pickRow1

	cmp userRow, 2
	je pickRow2

	cmp userRow, 3
	je pickRow3

;Then based on the row it jumps to row1, row2, row3
pickRow1:
	jmp row1
pickRow2:
	jmp row2
pickRow3:
	jmp row3

row1:
;Then checks the column and jumps to the proper placement
	cmp userCol, 1
	je pickCol1

	cmp userCol, 2
	je pickCol2

	cmp userCol, 3
	je pickCol3

;Column 1, Row 1
pickCol1:
	cmp al, data
	je done
	jmp notEqual

;Column 2, Row 1
pickCol2:
	cmp al, data + 1
	je done
	jmp notEqual

;Column 3, Row 1
pickCol3:
	cmp al, data + 2
	je done
	jmp notEqual

row2:
	cmp userCol, 1
	je pickCol12

	cmp userCol, 2
	je pickCol22

	cmp userCol, 3
	je pickCol32

;Column 1, Row 2
pickCol12:
	cmp al, data + 3
	je done
	jmp notEqual

;Column 2, Row 2
pickCol22:
	cmp al, data + 4
	je done
	jmp notEqual

;Column 3, Row 2
pickCol32:
	cmp al, data + 5
	je done
	jmp notEqual

row3:
	cmp userCol, 1
	je pickCol13

	cmp userCol, 2
	je pickCol23

	cmp userCol, 3
	je pickCol33

;Column 1, Row 3
pickCol13:
	cmp al, data + 6
	je done
	jmp notEqual

;Column 2, Row 3
pickCol23:
	cmp al, data + 7
	je done
	jmp notEqual

;Column 3, Row 3
pickCol33:
	cmp al, data + 8
	je done
	jmp notEqual

notEqual:
	mWriteStr error1
	call Crlf
	cmp whosTurn, 1
	je backToO

backToX:
	mXPrompt
	jmp start

backToO:
	mOPrompt
	jmp start

done:

ret
emptyCheck ENDP
@

end main