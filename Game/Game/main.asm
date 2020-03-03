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



mEvenRows MACRO	spaceOne, spaceTwo, spaceThree, row						;	fills rows with inputs 


	mov	eax, 4
	call WriteInt
	call Crlf
	mWriteStr spaceOne
	call WriteInt
	
ENDM




mPrint_Helper MACRO	row				;	prints row of parameter 

	
	mov ECX, 0

	rowloop:
	mov board[ECX][row], space
	inc ECX
	mov board[ECX][row], vert



	

ENDM


mMake_Board MACRO					;	this should fill the board matrix with the empty board. 


	mEvenRows vert, space, 0, 0
	mEvenRows hor, space, space, 1
	mEvenRows space, space, space, 2
	mEvenRows hor, space, space, 3
	mEvenRows space, space, space, 4


ENDM

mPrintRow MACRO	row

	mov EDI, 0
	mov EAX, 5

	sloop:

		cmp EDI, 5
		je exit

		mov mult, board[EDI][row]
		mWriteStr mult
		inc EDI


	loop sloop

	exit: 

ENDM



mPrint_Board MACRO					;	this should function like for(int i = 0; i < 5; i++){ for(int j = 0; j < 5; j++) }
									
	
	mPrintRow 0
	mPrintRow 1
	mPrintRow 2
	mPrintRow 4
	mPrintRow 4

	


ENDM





.data

	board	DWORD	5 DUP( 5 DUP(?))
	tboard	BYTE	25 DUP ("g ")
	array	BYTE	5 DUP(?)
	hor		BYTE	"_", 0
	vert	BYTE	"|", 0
	space	BYTE	" ", 0
	i		DWORD	0
	j		DWORD	0
	mult	DWORD	? 



.code
main PROC						;	****************************************


	;mov EDX, OFFSET vert
	;mov board[0][0], EDX
	;mov EAX, board[0][0]
	;call mWriteStr EAX

	;mov EAX, tboard[0]


	exit

main ENDP						;	****************************************



END main
