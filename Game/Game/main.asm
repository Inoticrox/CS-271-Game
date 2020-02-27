TITLE TicTacToe (main.asm)

INCLUDE C:/Irvine/Irvine32.inc
INCLUDELIB C:/Irvine/Irvine32.lib

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode: dword

.data
	board DWORD 5 DUP(5 DUP(?))

.code


main proc


	invoke ExitProcess, 0
main endp
end main