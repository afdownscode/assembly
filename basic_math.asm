TITLE CSCI 3410 Assignment 5 Procedures PASS5
comment ! 
Author: Allen Downs
CSCI 3410
Assignment 5

This program gives the user a choice between 3 options to perform mathematical
operations on a sequence of integers. The user can choose CalcPrime, CalcFib, or CalcSquares
!

INCLUDE Irvine32.inc
INCLUDE Macros.inc

.data
	primetitle		BYTE 	"Primes",13,10,0
	fibtitle		BYTE 	"Fibonacci",13,10,0
	squaretitle		BYTE 	"Squares",13,10,0
	bye				BYTE 	"Goodbye",13,10,0


.code
main PROC
	call			Menu


	exit
main ENDP

Menu PROC
	.data
	theGreeting		BYTE	"Fun with Numbers by Allen Downs",13,10,0
	menuZero		BYTE 	"0. Generate Primes",13,10,0
	menuOne			BYTE	"1. Generate Fibonacci Sequence",13,10,0
	menuTwo			BYTE	"2. Generate Squares",13,10,0
	menuThree		BYTE	"3. Exit Program",13,10,0
	choose			BYTE	"Choose Option <0-3>",13,10,0

	.code
	call			Clrscr
	mWriteString	theGreeting
	call			Crlf
	mWriteString	menuZero
	mWriteString	menuOne
	mWriteString	menuTwo
	mWriteString	menuThree
	call			Crlf

	mWriteString	choose
	call			ReadInt
	cmp eax,		0
	je				Prime
	cmp eax,		1
	je				Fib
	cmp eax,		2
	je				Square
	cmp	eax,		3
	je				Quit
Prime:
	call			CalcPrime
Fib:
	call			CalcFib
Square:
	call			CalcSquares
MenuReturn:
	call			Menu
Quit:
	mWriteString	bye
	call			WaitMsg
	invoke			ExitProcess,0
			
	ret
Menu ENDP



CalcPrime		PROC
	.data
	prime		BYTE 	"     Is Prime",13,10,0
	notprime	Byte	"     Is Not Prime",13,10,0

	.code
	call		PromptforNum
	call		Clrscr
	mWriteString	primetitle
	call			Crlf
	mov ecx, eax					;set loop counter with user input
	mov eax, 1						;reset eax
	mov esi, eax					;counter to check for prime
	
	
	
L1:
	mov edi, esi					; the current num to check
	call		IsPrime
	cmp eax, 0
	jz			NP
	ja			P
P:
	mov eax, esi					;put the current num in eax
	call		WriteInt
	mWriteString	prime
	jmp			Break	
NP:	
	mov eax, esi					;put the current num in eax
	call		WriteInt
	mWriteString	notprime
	jmp			Break
Break:
	inc esi
		loop L1
		
	call		WaitMsg
	call		Menu	
	ret
CalcPrime		ENDP

CalcFib			PROC
		call			PromptforNum
		call		Clrscr
		mWriteString	fibtitle
		call			Crlf
		mov ecx, eax
		mov eax, 1
		call	WriteInt			; first fib num is 1
		mov	al, TAB
		call	WriteChar
		mov eax, 1
		call	WriteInt
		call	Crlf
		mov ebx, 2					;track the seq num
		dec ecx						;the first num is done
		mov edx, 1					;use edx as last num
		mov edi, 0					;use edi as beforelast num
	FIB:
		mov eax, ebx
		call	WriteInt
		mov	al, TAB
		call	WriteChar
		mov eax, edx
		add edx, edi				;next fib seq num
		mov edi, eax				;put old sum in beforelast
		mov eax, edx
		call	WriteInt
		call Crlf
		inc ebx
		loop FIB
		call			WaitMsg
		call		Menu	
		ret
CalcFib			ENDP

CalcSquares		PROC
		call		PromptforNum
		call		Clrscr
		mWriteString	squaretitle
		call			Crlf
		mov ecx, eax					; loop count
		mov ebx, 1						; number to start squaring
	LS:
		mov eax, ebx
		mul ebx
		mov edi, eax
		mov eax, ebx
		call	WriteInt
		mov	al, TAB
		call	WriteChar
		mov eax, edi
		call	WriteInt
		call	Crlf
		inc ebx
		loop LS

		call		WaitMsg
		call		Menu	
		ret
CalcSquares		ENDP

PromptforNum	PROC
	.data
	numPrompt	BYTE	"Enter a number: "
	.code
	call		Clrscr
	mWriteString	numPrompt
	call		ReadInt	
	ret
PromptforNum	ENDP

IsPrime			PROC
		cmp edi, 1						;if edi = 1 then not prime
		jz	nP
		mov ebx, 2						;start  divisor number
	recheck:
		xor	edx, edx					;clear edx for div
		mov eax, edi					;reset eax
		cmp ebx, eax					;if num = divisor then Prime
		jz	iP
		div ebx							;divide by next divisor
		cmp edx, 0
		jz	nP							;not a prime if remainder = 0
		inc ebx							;move to next divisor (2,3,4,...)
		jmp	recheck
	nP:
		mov eax, 0
		ret
	iP:
		mov eax, 1
		ret

IsPrime			ENDP


END main