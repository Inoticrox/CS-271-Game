TITLE TicTacToe (main.asm)
;Test
INCLUDE C:/Irvine/Irvine32.inc
INCLUDELIB C:/Irvine/Irvine32.lib

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode: dword

.data
	

.code


main proc


	invoke ExitProcess, 0
main endp
end main