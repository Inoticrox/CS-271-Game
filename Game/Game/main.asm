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


mPrint_Board MACRO						;	prints board with row/col numbers

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




mEvenRows MACRO	spaceOne, spaceTwo, spaceThree, row						;	fills rows with inputs 

	mov board + (row * 5) , spaceOne
	mov board + 1 + (row * 5), 124
	mov board + 2 + (row * 5), spaceTwo
	mov board + 3 + (row * 5), 124
	mov board + 4 + (row * 5), spaceThree		


ENDM


mOddRows MACRO row														;	 fills row with "_____"

	mov board + (row * 5), 95
	mov board + 1 + (row * 5), 95
	mov board + 2 + (row * 5), 95
	mov board + 3 + (row * 5), 95
	mov board + 4 + (row * 5), 95


ENDM




mMake_Board MACRO					;	this fills the board matrix with the empty board. 

	mEvenRows 32, 32, 32, 0
	mOddRows 1	
	mEvenRows 32, 32, 32, 2
	mOddRows 3
	mEvenRows 32, 32, 32, 4

ENDM




mPrintRow MACRO	row					;	this prints a single row 

	mPrint_indice 0, (row * 5)
	mPrint_indice 1, (row * 5)
	mPrint_indice 2, (row * 5)
	mPrint_indice 3, (row * 5)
	mPrint_indice 4, (row * 5)


ENDM




mPrint_indice MACRO col, row				;	this prints a single indice 

	mov AL, board + col + row
	call WriteChar

ENDM

mPrint_data_indice MACRO indice				;	this prints a single indice from the data array 

	mov AL, data + indice
	call WriteChar

ENDM


mPlayer_turn MACRO row, col, X_O			;	a single move, places an X or O
											;	put in 0 for O, and 1 for X
	LOCAL Xs
	LOCAL Os
	LOCAL done

											
	mov EAX, 0

	cmp EAX, X_O
	je Os
	jne Xs

	Xs:
		mov board + ( row * 5 ) + col, 88
		jmp done
	Os:
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


mcheckRows MACRO x_o

	mov ah, x_o
	mov EAX, 0
	mov EDX, 0


	cmp ah, data + 
	je hit

	cmp ah, data + 1
	je hit

	cmp ah, data + 2
	je hit

		
	hit: 
		inc EAX
		








	finish: 
		mWriteStr win

ENDM




.data

	board		BYTE	5 DUP ( 5 DUP (?) )
	data		BYTE	9 DUP (?)
	cols		BYTE	"   1 2 3", 10, 0
	rowOne		BYTE	" 1 ", 0
	rowTwo		BYTE	" 2 ", 0
	rowThree	BYTE	" 3 ", 0
	space		BYTE	"   ", 0	
	win			BYTE	"	YOU WON!!!!!!	", 10, 0
	mult		DWORD	?
	
.code
main PROC						;	****************************************
	
	mMake_board

	mPlayer_turn 0, 0, 1
	mPlayer_turn 0, 2, 1
	mPlayer_turn 0, 4, 1


	
	mPrint_board	

	call winCheck




	exit

main ENDP						;	****************************************





winCheck PROC

	mFill_data
	mPrint_data



	mcheckRows "X"










	ret 


winCheck ENDP



END main
