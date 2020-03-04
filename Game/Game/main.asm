TITLE INTFP tictactoe (ttt.asm) 


;	Author: Hugh MacWilliams 
;	Course: CS271
;	Description:


INCLUDE Irvine32.inc	
.386
.stack 4096


MAX_SIZE = 25



mWriteStr MACRO input					;	macro to write strings to console 
	push EDX
	mov EDX, OFFSET input 
	call WriteString
	pop EDX

ENDM


mPrint_Ex MACRO

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


ENDM




mEvenRows MACRO	spaceOne, spaceTwo, spaceThree, row						;	fills rows with inputs 

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




mMake_Board MACRO					;	this should fill the board matrix with the empty board. 


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



mPrint_Board MACRO					;	this should function like for(int i = 0; i < 5; i++){ for(int j = 0; j < 5; j++) }
									
	
	mPrintRow 0
	call Crlf
	mPrintRow 1
	call Crlf
	mPrintRow 2
	call Crlf
	mPrintRow 3
	call Crlf	
	mPrintRow 4
	call Crlf
	call Crlf

ENDM


mPrint_indice MACRO col, row 

	mov AL, board + col + row
	call WriteChar

ENDM


mPlayer_turn MACRO row, col, X_O			;	a single move, places an X or O


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





.data

	board		BYTE	5 DUP ( 5 DUP (?) )
	cols		BYTE	"   1 2 3", 10, 0
	rowOne		BYTE	" 1 ", 0
	rowTwo		BYTE	" 2 ", 0
	rowThree	BYTE	" 3 ", 0
	space		BYTE	"   ", 0


.code
main PROC						;	****************************************
	
	
	mMake_board

	mPrint_Board

	mPlayer_turn 0, 0, 0
	mPrint_Board



	exit

main ENDP						;	****************************************



END main
