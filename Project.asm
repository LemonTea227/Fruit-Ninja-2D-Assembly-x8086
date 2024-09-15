.486
IDEAL

;================================================
; Description: goes to a new line in text mode
; Input: none
; Output: cursor is at the start of a new line
;================================================
MACRO NEW_LINE
	mov dl,13   ; CR = Caridge Return - go to row start position
	mov ah,2   
	int 21h
	mov dl,10   ;  LF = Line Feed - go down to the next line
	int 21h
ENDM LINE

;================================================
; Description: put a char on screen in text mode
; Input: 1. dl - the char
; 		 2. ah - the interrupt		 		
; Output: a char on screen
;================================================
MACRO PUT_CHAR   MY_CHAR
	mov dl,MY_CHAR
	mov ah,2
	int 21h
ENDM 


; macro RND
 ; mov ax, 40h

; mov es, ax

; mov ax, [es:6Ch]

; and ax, 7
; endm

MODEL small

MOUSE_COLORred equ 127 ; red
MOUSE_COLORgreen equ 255 ; green
MOUSE_COLORblue equ 127 ; blue

MOUSE_COLORyellow equ 251 ; red



; MaxFloodStackDepth = 50

; Fill_Color = 8
; Fill_Color_Border = 0



STACK 0f500h

FILE_NAME_IN1  equ 'WoodBgSt.bmp' ;320*200         ;play = 48-89X   72-116Y     ;Exit = 226-260X   71-116Y
FILE_NAME_IN2  equ 'MidBg.bmp'	;320*200
FILE_NAME_IN3 equ 'WaterM.bmp' ;50*39
FILE_NAME_IN4 equ 'Banana.bmp' ;50*39
FILE_NAME_IN5 equ 'Apple.bmp' ;50*39
FILE_NAME_IN6 equ 'Papple.bmp' ;50*39
FILE_NAME_IN7 equ 'EmptyX.bmp' ;24*20
FILE_NAME_IN8 equ 'FullX.bmp' ;24*20
FILE_NAME_IN9  equ 'ENDGAME.bmp' ;320*200         ;play again = 48-89X   72-116Y     ;Exit = 226-260X   71-116Y
FILE_NAME_IN10 equ 'pause.bmp' ;27*20
FILE_NAME_IN11 equ 'resume.bmp' ;27*20
FILE_NAME_IN12 equ 'exit.bmp' ;27*20
FILE_NAME_IN13 equ 'bomby.bmp' ;50*39
FILE_NAME_IN14 equ 'explosy.bmp' ;50*39
FILE_NAME_IN15 equ 'Cherry.bmp' ;50*39

BMP_WIDTH = 320
BMP_HEIGHT = 200



DATASEG
	;Random
	RndCurrentPos dw start

	; array for mouse int 33 ax=09 (not a must) 64 bytes
	ClickHere db "Click Here!"
	LenClickHere = $ - ClickHere
	
	  MouseMask dw 1001111111111111b
            dw 1010111111111111b
            dw 1011011111111111b
            dw 1011101111111111b
			
            dw 1011110111111111b
			dw 1101111011111111b
			dw 1110111101111111b
            dw 1111011110011111b
			
            dw 1111101110001111b
            dw 1111110100001111b
            dw 1111111000000111b
            dw 1111110000000011b
			
            dw 1111111001100001b
            dw 1111111111110000b
            dw 1111111111111000b
            dw 1111111111111001b

	  
			; dw 1111111111111111b
            ; dw 1111111111111111b
            ; dw 1111111111111111b
            ; dw 1111111111111111b
			
            ; dw 1111111111111111b
            ; dw 1111111111111111b
            ; dw 1111111111111111b
            ; dw 1111111111111111b
			
            ; dw 1111111111111111b
            ; dw 1111111111111111b
            ; dw 1111111111111111b
            ; dw 1111111111111111b
			
            ; dw 1111111111111111b
            ; dw 1111111111111111b
            ; dw 1111111111111111b
            ; dw 1111111111111111b
				
			

            ; dw 0000000100000000b
            ; dw 0000000100000000b
            ; dw 0000000100000000b
            ; dw 0000000100000000b
			
            ; dw 0000000100000000b
            ; dw 0000000100000000b
            ; dw 0000000100000000b
            ; dw 1111111011111111b
			
            ; dw 0000000100000000b
            ; dw 0000000100000000b
            ; dw 0000000100000000b
            ; dw 0000000100000000b
			
            ; dw 0000000100000000b
            ; dw 0000000100000000b
            ; dw 0000000100000000b
            ; dw 0000000100000000b
			
			
			
			
			; cursor mask ---
            dw 0000000000000000b
            dw 0010000000000000b
            dw 0011000000000000b
            dw 0011100000000000b
			
            dw 0011110000000000b
            dw 0001111000000000b
            dw 0000111100000000b
            dw 0000011110000000b
			
            dw 0000001110100000b
            dw 0000000101100000b
            dw 0000000011010000b
            dw 0000000110011000b
			
            dw 0000000000001100b
            dw 0000000000000110b
            dw 0000000000000010b
            dw 0000000000000000b
		
			
			  
			  			  
	; see http://cs.nyu.edu/~yap/classes/machineOrg/info/mouse.htm
	Color db ?
	Xclick dw ?
	Yclick dw ?
	Xp dw ?
	Yp dw ?
	SquareSize dw ?
	GotClick db ?

    OneBmpLine 	db BMP_WIDTH dup (0)  ; One Color line read buffer
   
    ScrLine 	db BMP_WIDTH dup (0)  ; One Color line read buffer

	;BMP File data
	FileName1 	db FILE_NAME_IN1 ,0
	FileName2 	db FILE_NAME_IN2 ,0
	FileName3 	db FILE_NAME_IN3 ,0
	FileName4 	db FILE_NAME_IN4 ,0
	FileName5 	db FILE_NAME_IN5 ,0
	FileName6 	db FILE_NAME_IN6 ,0
	FileName7 	db FILE_NAME_IN7 ,0
	FileName8 	db FILE_NAME_IN8 ,0
	FileName9 	db FILE_NAME_IN9 ,0
	FileName10 	db FILE_NAME_IN10,0
	FileName11 	db FILE_NAME_IN11,0
	FileName12 	db FILE_NAME_IN12,0
	FileName13 	db FILE_NAME_IN13,0
	FileName14 	db FILE_NAME_IN14,0
	FileName15 	db FILE_NAME_IN15,0
	
	; vars for bmp files
	FileHandle	dw ?
	Header 	    db 54 dup(0)
	Palette 	db 400h dup (0)
	BmpLeft dw ?
	BmpTop dw ?
	BmpColSize dw ?
	BmpRowSize dw ?
		
;BmpFileErrorMsg    	db 'Error At Opening Bmp File ',FILE_NAME_IN1, 0dh, 0ah,'$'
	ErrorFile           db 0
; BB db "BB..",'$'
	
	
	
	;a flag that checks if the game should finish
	finish db 0
	
; lastTop dw 50
; lastLeft dw 50
	
; thisTop dw ?
; thisLeft dw ?
; thisRight dw ? ;[thisLeft]+68d
; thisDown dw ? ;[thisTop]+53d
	
	;vars that are responsible for the tries you have left
	LastHp db 3
	HP db 3 
	
;function AX^2 + BX + C    (although the function will act as a negtive function we will use a positive function to make the parabola we want)
; Aparabola db 128 ;(2^7) ;this number will dived the 'y' of the function with. it is a constant in all functions and it will make A of the prabola in the end smaller than 1 and bigger than 0
; Bparabola db 0   ;this number aloways equls to 0 to make things simple
; Cparabola db 50   ;this is a number that we will add to the 'y' of the of the point in the end of the calculation
; PlacmentDiv equ 160 ;need to div 160 from the real x
	
	XNowPr dw 0
	EndXNowPr dw 0
	YNowPr dw ?
	EndYNowPr dw ?
	
;function now is X^2/100 + 0X + 50
;and i will run on her -160 = x until 160=X
	
;counts how many times the function tached the bottom of the screen
; CntFloor db 0
	
	;the vars that are related to the function
	; LengthOfFuction dw 27
	; Xs dw 000,005,010,015,020,025,030,035,040,045,050,055,060,065,070,075,080,085,090,095,100,105,110,115,120,125,130;27     000,010,020,030,040,050,060,070,080,090,100,110,120;13
	; Ys dw 199,177,160,144,130,117,106,096,088,081,076,072,070,069,070,072,076,081,088,096,106,117,130,140,160,177,199;27     199,155,110,075,050,035,030,035,050,075,110,155,199;13
	
	; LengthOfFuction dw 27 
	; Xs dw 000,005,010,015,020,025,030,035,040,045,050,055,060,065,070,075,080,085,090,095,100,105,110,115,120,125,130,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000;max length 45
	; Ys dw 199,177,160,144,130,117,106,096,088,081,076,072,070,069,070,072,076,081,088,096,106,117,130,140,160,177,199,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000;max length 45
	
	LengthOfFuction dw 0 
	Xs dw 000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000;max length 45
	Ys dw 000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000;max length 45
	
	LengthOfFuction1 dw 27 ;-0.03X^2 - 69
	Xs1 dw 000,005,010,015,020,025,030,035,040,045,050,055,060,065,070,075,080,085,090,095,100,105,110,115,120,125,130;27     000,010,020,030,040,050,060,070,080,090,100,110,120;13
	Ys1 dw 199,177,160,144,130,117,106,096,088,081,076,072,070,069,070,072,076,081,088,096,106,117,130,140,160,177,199;27     199,155,110,075,050,035,030,035,050,075,110,155,199;13
	
	LengthOfFuction2 dw 15 ;-0.005x^2 - 170
	Xs2 dw 000,010,020,030,040,050,060,070,080,090,100,110,120,130,140,150;15     
	Ys2 dw 199,195,188,182,178,174,172,170,170,172,174,178,182,188,195,199;15     
	
	LengthOfFuction3 dw 16 ;-0.5x^2 -69
	Xs3 dw 000,002,004,006,008,010,012,014,016,018,020,022,024,026,028,030;16     
	Ys3 dw 199,154,119,101,087,077,071,069,069,071,077,087,101,119,154,199;16  

	LengthOfFuction4 dw 27 ;+0.03X^2 - 69
	Xs4 dw 000,005,010,015,020,025,030,035,040,045,050,055,060,065,070,075,080,085,090,095,100,105,110,115,120,125,130;27     000,010,020,030,040,050,060,070,080,090,100,110,120;13
	Ys4 dw 069,070,072,076,081,088,096,106,117,130,140,160,177,199,177,160,140,130,117,106,096,088,081,076,072,070,069;27     199,155,110,075,050,035,030,035,050,075,110,155,199;13
	
	
	CntFirst db 0 ;flag that responsible of knowing if it the first draw of the fruit
	VarOffset dw ? ;wich fruit to draw
	
	XsLength dw 0
	
	RndAddToX dw 0 ;responsible of the place of the start of the function
	
	lengthM = 39 ;length of the fruits
	widthM = 50  ;width of the fruits
	
	CntTaped db 0 ;flag that id responsible to know if the fruit was cuted
	score dw 0 ;the score of the player
	ScorePrint db "SCORE: ","$"
	
	CntGames db 0
	
	Pflag db 0 ;paused or playing
	PfalgOut db 0 ;checkes for exit
CODESEG
 
Start:                         
	mov ax,@data			 
	mov ds,ax		

	call setGraphic 
	
	; show mouse
		mov ax,01h
		int 33h	
	
	call setKnifeMouse
		
	call DrawWoodBgSt
	
	
	call CheckOpenScreen
		
	
	cmp [finish],0
	jnz exit
	mov [finish],0
	jmp Game
	
Game:
	call DrawBack
	call PutHpOnScreen
	call PutStatusOnScreen
	
	call setAsyncMouse ;line 493
	
	call GoToNewRow
LoopGameMode1: ;cut until you lose
	call PutStatusOnScreen
	cmp [PfalgOut],1
	je FinishGame
	call PrintScore
	;call LoopDelayQuarterSec
	
	; call RndToX
	
	call RndThrow
	call ChangeHpOnScreen
		
	cmp [HP],0
	jle FinishGame
	
	jmp LoopGameMode1
	
FinishGame:

	push cx  ;make musk to 0
	push ax
	mov ax,0ch
	mov cx,0
	int 33h
	pop ax
	pop cx

	
	call DrawENDGAME
	
	mov [HP],3
	mov [LastHp],3
	mov [SCORE],0
	mov [Pflag],0
	mov [PfalgOut],0
	
	mov ah,0
	int 16h
	
	cmp al,'r'     ;checks for a key if equals to 'r' he will play again and if not he will exit
	je Game
	cmp al,'R'
	je Game
	jmp exit
	
	
exit:
	
	call setTextMode
	mov ax,4C00h
    int 21h
	
	
;==========================
;==========================
;===== Procedures  Area ===
;==========================
;==========================

;================================================
; Description: 
; Input: 1. 
;		 2.	
;		 3. 		
; Output: 
; Changes: 
;================================================


;================================================
; Description: checks what the open screen should do (play or exit)
; Input: none	 		
; Output: [finish]
; Changes: [finish]
;================================================
proc CheckOpenScreen
push dx
push cx
push bx
push ax
@@openScreen:              ;wait until a butten is presed if it is 'play' he will jump to game and if 'exit' he will exit
	mov ax,3
	int 33h
	cmp bx,1
	jne @@openScreen
	shr cx,1
	cmp cx,48
	jb @@openScreen
	cmp cx,89
	ja @@checkExit
	cmp dx,72
	jb @@openScreen
	cmp dx,116
	ja @@openScreen
	mov [finish],0
	; jmp Game
	jmp @@finish
	
@@checkExit:
	cmp cx,226
	jb @@openScreen
	cmp cx,260
	ja @@openScreen
	cmp dx,72
	jb @@openScreen
	cmp dx,116
	ja @@openScreen
	mov [finish],1
	; jmp @@exit
	jmp @@finish
	
@@finish:
pop ax
pop bx
pop cx
pop dx 	
ret
endp CheckOpenScreen

;================================================
; Description: draws the openScreen on screen
; Input: 
; Output: on screen
; Changes: [BmpLeft],[BmpTop],[BmpColSize],[BmpRowSize]
;================================================
proc DrawWoodBgSt
push ax
push dx
push si
push di

	; hide mouse
		mov ax,02h
		int 33h	
		
	mov [BmpLeft],0
	mov [BmpTop],0
	mov [BmpColSize], 320
	mov [BmpRowSize], 200
	
	mov dx, offset FileName1
	call OpenShowBmp
	; show mouse
		mov ax,01h
		int 33h	
pop di
pop si
pop dx
pop ax
ret
endp DrawWoodBgSt

;================================================
; Description: draws the closeScreen on screen
; Input: 
; Output: on screen
; Changes: [BmpLeft],[BmpTop],[BmpColSize],[BmpRowSize]
;================================================
proc DrawENDGAME
push ax
push dx
push si
push di

	; hide mouse
		mov ax,02h
		int 33h	
		
	mov [BmpLeft],0
	mov [BmpTop],0
	mov [BmpColSize], 320
	mov [BmpRowSize], 200
	
	mov dx, offset FileName9
	call OpenShowBmp
	; show mouse
		mov ax,01h
		int 33h	
pop di
pop si
pop dx
pop ax
ret
endp DrawENDGAME

;================================================
; Description: draws the HP on screen
; Input: [HP]
; Output: on screen
; Changes: [BmpLeft],[BmpTop],[BmpColSize],[BmpRowSize]
;================================================
proc PutHpOnScreen
push ax
push dx
push si
push di

	cmp [Hp],3
	je @@Put3
	cmp [Hp],2
	je @@Put2
	cmp [Hp],1
	je @@Put1
	jmp @@Put0
	
@@put3:
	mov [BmpLeft],293
	mov [BmpTop],1
	mov [BmpColSize], 24
	mov [BmpRowSize], 20
	mov dx, offset FileName7
	call OpenShowBmp
	
	mov [BmpLeft],264
	mov [BmpTop],1
	mov [BmpColSize], 24
	mov [BmpRowSize], 20
	mov dx, offset FileName7
	call OpenShowBmp
	
	mov [BmpLeft],235
	mov [BmpTop],1
	mov [BmpColSize], 24
	mov [BmpRowSize], 20
	mov dx, offset FileName7
	call OpenShowBmp
	
	jmp @@finish
	
@@put2:
	mov [BmpLeft],293
	mov [BmpTop],1
	mov [BmpColSize], 24
	mov [BmpRowSize], 20
	mov dx, offset FileName8
	call OpenShowBmp
	
	jmp @@finish
	
@@put1:
	mov [BmpLeft],264
	mov [BmpTop],1
	mov [BmpColSize], 24
	mov [BmpRowSize], 20
	mov dx, offset FileName8
	call OpenShowBmp
	
	
	jmp @@finish
	
@@put0:
	mov [BmpLeft],293
	mov [BmpTop],1
	mov [BmpColSize], 24
	mov [BmpRowSize], 20
	mov dx, offset FileName8
	call OpenShowBmp
	
	mov [BmpLeft],264
	mov [BmpTop],1
	mov [BmpColSize], 24
	mov [BmpRowSize], 20
	mov dx, offset FileName8
	call OpenShowBmp
	
	mov [BmpLeft],235
	mov [BmpTop],1
	mov [BmpColSize], 24
	mov [BmpRowSize], 20
	mov dx, offset FileName8
	call OpenShowBmp
	
	jmp @@finish
	
@@finish:	
pop di
pop si
pop dx
pop ax
ret
endp PutHpOnScreen

;================================================
; Description: draws the Status on screen
; Input: [Pflag]
; Output: on screen
; Changes: [BmpLeft],[BmpTop],[BmpColSize],[BmpRowSize]
;================================================
proc PutStatusOnScreen
push ax
push dx
push di
push si
; hide mouse
		mov ax,02h
		int 33h	
		
	mov [BmpLeft],147
	mov [BmpTop],0
	mov [BmpColSize], 27
	mov [BmpRowSize], 20
	
	cmp [Pflag],0 ;pause =0
	jz @@Pause
	cmp [Pflag],1 ;resume =1
	je @@resume
	jmp @@exit ;exit =2
@@resume:	
	mov dx, offset FileName11
	jmp @@finish
@@pause:
	mov dx, offset FileName10
	jmp @@finish
@@exit:
	mov dx, offset FileName12
	jmp @@finish
	
@@finish:
	call OpenShowBmp

; show mouse
		mov ax,01h
		int 33h
pop si		
pop di
pop dx
pop ax
ret
endp PutStatusOnScreen

;================================================
; Description: waits until the pause will change and prints status
; Input: [Pflag],[PfalgOut]
; Output: on screen
; Changes: 
;================================================
proc PauseGame
@@LoopPause:
	cmp [Pflag],0
	je @@finish
	cmp [PfalgOut],1
	je @@finish
	jmp @@LoopPause
@@finish:
	call PutStatusOnScreen
ret 
endp PauseGame

;================================================
; Description: draws the HP on screen if changed
; Input: [HP],[LastHp]
; Output: on screen
; Changes: from other procs
;================================================
proc ChangeHpOnScreen
	push ax
	mov al,[LastHp]
	cmp [Hp],al
	jb @@DrawAgain
	jmp @@finish
@@DrawAgain:
	call PutHpOnScreen
	jmp @@finish
@@finish:
	pop ax
ret
endp ChangeHpOnScreen

;================================================
; Description: goes to a new row if it's the first game
; Input: [CntGames]
; Output: on screen
; Changes: 
;================================================
proc GoToNewRow
push dx
push ax
	
	cmp [CntGames],0
	jnz @@DontEnter
	
	
	mov ah,2
	mov dl,10
	int 21h
	
	inc [CntGames]
@@DontEnter:	
	
pop ax
pop dx
ret
endp GoToNewRow

;================================================
; Description: prints the current score on screen
; Input: [score],[ScorePrint]
; Output: on screen
; Changes: from other procs
;================================================
Proc PrintScore
	pusha
	
	
	mov ah,2
	mov dl,13
	int 21h
	
	
	mov ah, 9
	mov dx, offset ScorePrint
	int 21h
	
	mov ax,[score]
	call printAxDec
	
	popa
ret
endp PrintScore

;================================================
; Description: chooses a random function and insert it to the throw function
; Input: 
; Output: 
; Changes: 
;================================================
proc RndFuction
	push si
	push bx
	push ax
	
	mov bl,1
	mov bh,4	 
	call RandomByCs
	
	cmp al,1
	jne @@next_check2
	call CopyFuction1
	jmp @@finish
@@next_check2:
	cmp al,2
	jne @@next_check3
	call CopyFuction2
	jmp @@finish
@@next_check3:
	cmp al,3
	jne @@next_check4
	call CopyFuction3
	jmp @@finish
@@next_check4:
	call CopyFuction4
	jmp @@finish
	
	
@@finish:	
	pop ax
	pop bx
	pop si
ret
endp RndFuction


proc CopyFuction1
push si
push dx
push cx
push bx
push ax

	mov ax,[LengthOfFuction1]
	mov[LengthOfFuction],ax
	
	mov si,0
	mov cx,[LengthOfFuction1]
@@loopCopy:	
	mov bx,[Xs1+si]
	mov [Xs+si],bx
	mov dx,[Ys1+si]
	mov [Ys+si],dx
	add si,2
	loop @@loopCopy
	
	mov [XsLength],bx
pop ax
pop bx
pop cx
pop dx
pop si
ret
endp CopyFuction1

proc CopyFuction2
push si
push dx
push cx
push bx
push ax

	mov ax,[LengthOfFuction2]
	mov[LengthOfFuction],ax
	
	mov si,0
	mov cx,[LengthOfFuction2]
@@loopCopy:	
	mov bx,[Xs2+si]
	mov [Xs+si],bx
	mov dx,[Ys2+si]
	mov [Ys+si],dx
	add si,2
	loop @@loopCopy

	mov [XsLength],bx
pop ax
pop bx
pop cx
pop dx
pop si
ret
endp CopyFuction2

proc CopyFuction3
push si
push dx
push cx
push bx
push ax

	mov ax,[LengthOfFuction3]
	mov[LengthOfFuction],ax
	
	mov si,0
	mov cx,[LengthOfFuction3]
@@loopCopy:	
	mov bx,[Xs3+si]
	mov [Xs+si],bx
	mov dx,[Ys3+si]
	mov [Ys+si],dx
	add si,2
	loop @@loopCopy

	mov [XsLength],bx
pop ax
pop bx
pop cx
pop dx
pop si
ret
endp CopyFuction3

proc CopyFuction4
push si
push dx
push cx
push bx
push ax

	mov ax,[LengthOfFuction4]
	mov[LengthOfFuction],ax
	
	mov si,0
	mov cx,[LengthOfFuction4]
@@loopCopy:	
	mov bx,[Xs4+si]
	mov [Xs+si],bx
	mov dx,[Ys4+si]
	mov [Ys+si],dx
	add si,2
	loop @@loopCopy
	
	mov [XsLength],bx
pop ax
pop bx
pop cx
pop dx
pop si
ret
endp CopyFuction4

;================================================
; Description: makes a random throw of a curtain furit
; Input: 
; Output: on screen
; Changes: from other procs
;================================================
Proc RndThrow
push bx
push ax
	 mov [cntTaped],0

	 call RndFuction
	 
	 call RndToX

	 mov bl,0
	 mov bh,1	 
	 call RandomByCs
	 
	 mov ah,0
	 cmp ax,0
	 jz @@RThrow
	 call SimpleThrow2Back
	 jmp @@finish
@@RThrow:	 
	call SimpleThrow2
	jmp @@finish
@@finish:	 
pop ax
pop bx
ret 
endp RndThrow

;================================================
; Description: generates a random number for the start of a function
; Input: [XsLength]
; Output: [RndAddToX]
; Changes: [RndAddToX]
;================================================
proc RndToX
push bx
push dx
push ax

	mov bx,0
	mov dx,320
	sub dx,WidthM
	sub dx,[XsLength]
	call RandomByCsWord
	mov [RndAddToX],ax
	
pop ax
pop dx
pop bx 
ret 
endp


;================================================
; Description: print the fruit if the fuction name
; Input: 
; Output: on screen, [score], [HP]
; Changes: [BmpLeft],[BmpTop],[BmpColSize],[BmpRowSize],[XNowPr],[YNowPr],[EndXNowPr],[EndYNowPr]
;================================================
proc SimpleThrow2
	pusha
	
	xor si,si
	xor di,di
	

@@loopThrow:
; checks change in Status  
	; cmp [Pflag],1
	; je @@Freeze
	; cmp [Pflag],2
	; je @@Freeze
	; jmp @@Continue
; @@Freeze:
	; pusha
	
	; push cx  ;make musk to 0
	; push ax
	; mov ax,0ch
	; mov cx,0
	; int 33h
	; pop ax												move to mousehandle
	; pop cx

	; mov ax,3
	; int 33h
	; shr cx,1

; cmp cx,147
; jb @@pass
; cmp cx,173
; ja @@pass
; cmp dx,0
; jb @@pass
; cmp dx,21
; ja @@notpass
; jmp @@pass

; @@notpass:
; popa
; jmp @@Continue

; @@pass:	
	; cmp bx,0000001b
	; je @@DoComend
	; cmp [Pflag],1
	; je @@CheckChange
	; cmp [Pflag],2
	; je @@CheckChange
	; popa
	; jmp @@Continue
; @@CheckChange:	
	; cmp bx,0000010b
	; je @@Change
	; popa
	; jmp @@Continue 
; @@DoComend:	
	; cmp [Pflag],0
	; je @@ToResumeB 
	; popa
	; cmp[Pflag],1
	; je @@Continue
	; mov [PfalgOut],1
	; jmp @@FinishThrow
; @@Change:
	; cmp[Pflag],1
	; je @@ToExitB
	; jmp @@ToResumeB
; @@ToExitB:
	; mov [Pflag],2
	; call PutStatusOnScreen
	; call LoopDelayEightheSec
	; jmp @@DoneChange
; @@ToResumeB:
	; mov [Pflag],1
	; call PutStatusOnScreen
	; call LoopDelayEightheSec
	; jmp @@DoneChange
; @@DoneChange:	
	; popa
	; jmp @@loopThrow
;	
; @@Continue:
	
	; call setAsyncMouse
	; mov [Pflag],0
	; call PutStatusOnScreen
	
	cmp [Pflag],0
	jne @@PauseThrow
	jmp @@Continue

@@PauseThrow:
	call PauseGame
	cmp [PfalgOut],1
	je @@FinishThrow
	jmp @@Continue
@@Continue:

push dx
push cx

	mov cx,[Xs+si]
	add cx,[RndAddToX]
	mov dx,[Ys+si]
	sub dx,LengthM 
	mov [XNowPr],cx ;moves to [XNowPr] the current [BmpLeft]
	mov [YnowPr],dx ;moves to [YNowPr] the current [BmpTop]
	mov [EndXNowPr],cx 
	mov [EndYNowPr],dx
	add [EndXNowPr],WidthM ;moves to [EndXNowPr] the current "[BmpRight]"
	add [EndYNowPr],LengthM ;moves to [EndYNowPr] the current "[BmpButtom]"
	call DrawRandomFruit     
	call LoopSmallDelay ;waits a delay
	call BackTOBgColor ;draws on the last fruit the BG color
	
pop cx
pop dx
	
	inc di
	
	
	
	add si,2
	;cmp [cntfloor],2
	;jb @@loopThrow
	;dec [HP]
	cmp [CntTaped],0
	ja @@AddToScore
	cmp di,[LengthOfFuction]
	jb @@loopThrow
	cmp [VarOffset],offset FileName13
	je @@FinishThrow
	dec [HP]
	jmp @@FinishThrow
@@AddToScore:
	cmp [VarOffset],offset FileName13
	je @@BOOM
	inc [score]	
	cmp [VarOffset],offset FileName15
	jne @@FinishThrow
	inc [score]
	jmp @@FinishThrow
@@BOOM:
	sub [HP],3
	mov cx,[XNowPr]
	mov dx,[YnowPr]
	call DrawBoom
	call LoopDelay1Sec
	jmp @@FinishThrow
@@FinishThrow:
	; mov [CntFloor],0
	mov [CntTaped],0
	mov [CntFirst],0
	
	popa
ret
endp SimpleThrow2

;================================================
; Description: print the fruit if the fuction name
; Input: 
; Output: on screen, [score], [HP]
; Changes: [BmpLeft],[BmpTop],[BmpColSize],[BmpRowSize],[XNowPr],[YNowPr],[EndXNowPr],[EndYNowPr]
;================================================
proc SimpleThrow2Back
	pusha
	
	xor si,si
	xor di,di
	mov si,[LengthOfFuction]
	dec si
	shl si,1
	

@@loopThrow:
; checks change in Status
	; cmp [Pflag],1
	; je @@Freeze
	; cmp [Pflag],2
	; je @@Freeze
	; jmp @@Continue
; @@Freeze:
	; pusha
	
	; push cx  ;make musk to 0
	; push ax
	; mov ax,0ch
	; mov cx,0													move to mousehandle
	; int 33h
	; pop ax
	; pop cx

	; mov ax,3
	; int 33h
	; shr cx,1

; cmp cx,147
; jb @@pass
; cmp cx,173
; ja @@pass
; cmp dx,0
; jb @@pass
; cmp dx,21
; ja @@notpass
; jmp @@pass

; @@notpass:
; popa
; jmp @@Continue

; @@pass:	
	; cmp bx,0000001b
	; je @@DoComend
	; cmp [Pflag],1
	; je @@CheckChange
	; cmp [Pflag],2
	; je @@CheckChange
	; popa
	; jmp @@Continue
; @@CheckChange:	
	; cmp bx,0000010b
	; je @@Change
	; popa
	; jmp @@Continue 
; @@DoComend:	
	; cmp [Pflag],0
	; je @@ToResumeB 
	; popa
	; cmp[Pflag],1
	; je @@Continue
	; mov [PfalgOut],1
	; jmp @@FinishThrow
; @@Change:
	; cmp[Pflag],1
	; je @@ToExitB
	; jmp @@ToResumeB
; @@ToExitB:
	; mov [Pflag],2
	; call PutStatusOnScreen
	; call LoopDelayEightheSec
	; jmp @@DoneChange
; @@ToResumeB:
	; mov [Pflag],1
	; call PutStatusOnScreen
	; call LoopDelayEightheSec
	; jmp @@DoneChange
; @@DoneChange:	
	; popa
	; jmp @@loopThrow
;	
; @@Continue:
	
	; call setAsyncMouse
	; mov [Pflag],0
	; call PutStatusOnScreen
	
	cmp [Pflag],0
	jne @@PauseThrow
	jmp @@Continue

@@PauseThrow:
	call PauseGame
	cmp [PfalgOut],1
	je @@FinishThrow
	jmp @@Continue
@@Continue:

push dx
push cx
	
	mov cx,[Xs+si]
	add cx,[RndAddToX]
	mov dx,[Ys+si]
	sub dx,LengthM 
	mov [XNowPr],cx ;moves to [XNowPr] the current [BmpLeft]
	mov [YnowPr],dx ;moves to [YNowPr] the current [BmpTop]
	mov [EndXNowPr],cx 
	mov [EndYNowPr],dx
	add [EndXNowPr],WidthM ;moves to [EndXNowPr] the current "[BmpRight]"
	add [EndYNowPr],LengthM ;moves to [EndYNowPr] the current "[BmpButtom]"
	call DrawRandomFruit     
	call LoopSmallDelay ;waits a delay
	call BackTOBgColor ;draws on the last fruit the BG color

pop cx
pop dx
	
	inc di
	
	
	
	sub si,2
	;cmp [cntfloor],2
	;jb @@loopThrow
	;dec [HP]
	cmp [CntTaped],0
	ja @@AddToScore
	cmp di,[LengthOfFuction]
	jb @@loopThrow
	cmp [VarOffset],offset FileName13
	je @@FinishThrow
	dec [HP]
	jmp @@FinishThrow
@@AddToScore:
	cmp [VarOffset],offset FileName13
	je @@BOOM
	inc [score]	
	cmp [VarOffset],offset FileName15
	jne @@FinishThrow
	inc [score]
	jmp @@FinishThrow
@@BOOM:
	sub [HP],3
	mov cx,[XNowPr]
	mov dx,[YnowPr]
	call DrawBoom
	call LoopDelay1Sec
	jmp @@FinishThrow
@@FinishThrow:
	; mov [CntFloor],0
	mov [CntTaped],0
	mov [CntFirst],0	
	
	popa
ret
endp SimpleThrow2Back

;================================================
; Description: print the middle background
; Input: 
; Output: on screen
; Changes: [BmpLeft],[BmpTop],[BmpColSize],[BmpRowSize]
;================================================
proc DrawBack
push ax
push dx
push di
push si
	; hide mouse
		mov ax,02h
		int 33h
		
	mov [BmpLeft],0
	mov [BmpTop],0
	mov [BmpColSize], 320
	mov [BmpRowSize] ,200
	
	mov dx, offset FileName2       ;prints the background
	call OpenShowBmp
	
	; show mouse
		mov ax,01h
		int 33h
		
pop si		
pop di
pop dx
pop ax
ret
endp DrawBack


; proc DrawWaterM
	; pusha
	; hide mouse
		; mov ax,02h
		; int 33h

	; mov [BmpLeft],cx
	; mov [BmpTop],dx
	; mov [BmpColSize], WidthM
	; mov [BmpRowSize], LengthM
	
	; mov dx, offset FileName3 
	; call OpenShowBmp
	
	; show mouse
		; mov ax,01h
		; int 33h
	; popa
; ret
; endp DrawWaterM

;================================================
; Description: print a random fruit at a curtain placement
; Input: cx,dx,[CntFirst]
; Output: on screen
; Changes: [BmpLeft],[BmpTop],[BmpColSize],[BmpRowSize],[VarOffset]
;================================================
proc DrawRandomFruit
pusha
	; hide mouse
		mov ax,02h
		int 33h

	mov [BmpLeft],cx
	mov [BmpTop],dx
	mov [BmpColSize], WidthM
	mov [BmpRowSize], LengthM
	
	cmp [CntFirst],0
	jnz @@DrawSame
	inc [CntFirst]
	
	
	mov bl,3
	mov bh,8	 
	call RandomByCs
	
	cmp al,3
	jne @@next_check1
	mov dx, offset FileName3
	mov [VarOffset],offset FileName3
	jmp @@draw
@@next_check1:
	cmp al,4
	jne @@next_check2
	mov dx, offset FileName4
	mov [VarOffset],offset FileName4
	jmp @@draw
@@next_check2:
	cmp al,5
	jne @@next_check3
	mov dx, offset FileName5
	mov [VarOffset],offset FileName5
	jmp @@draw
@@next_check3:
	cmp al,6
	jne @@next_check4
	mov dx, offset FileName6
	mov [VarOffset],offset FileName6
	jmp @@draw
@@next_check4:
	cmp al,7
	jne @@next_check5
	mov dx, offset FileName13
	mov [VarOffset],offset FileName13
	jmp @@draw
@@next_check5:
	mov dx, offset FileName15
	mov [VarOffset],offset FileName15
	jmp @@draw

@@DrawSame:
	mov dx,[VarOffset]
	jmp @@draw

@@draw:	
	call OpenShowBmp
	
	; show mouse
		mov ax,01h
		int 33h
popa
ret
endp DrawRandomFruit

;================================================
; Description: prints the explosion of the bomb
; Input: cx,dx
; Output: on screen
; Changes: [BmpLeft],[BmpTop],[BmpColSize],[BmpRowSize]
;================================================
proc DrawBoom
push dx
push cx	

	; hide mouse
		mov ax,02h
		int 33h
	
	mov [BmpLeft],cx
	mov [BmpTop],dx
	mov [BmpColSize], WidthM
	mov [BmpRowSize], LengthM
	mov dx, offset FileName14
	
	call OpenShowBmp
	
	; show mouse
		mov ax,01h
		int 33h
	
pop cx	
pop dx
ret
endp DrawBoom

;================================================
; Description: print on a fruit at a curtain placement the background
; Input: [XNowPr] - were to earase x , [YnowPr] - were to earace y
; Output: on screen
; Changes: from other procs
;================================================
proc BackTOBgColor
push es
		
		push 0A000h  ; in order to write directly to video memory we must set es the address
		pop es

pusha

push ax
	; hide mouse
		mov ax,02h
		int 33h
pop ax

		
mov di,[YnowPr]
add di,lengthM
@@DoThisY:
mov dx,di
mov si,[XNowPr]
add si,widthM
@@DoThisX:
mov cx,si
push ax
push bx
call GetBgColor
mov ah, 0ch
mov bx,0
int 10h
pop bx
pop ax
dec si
cmp si,[XNowPr]
jnz @@DoThisX
dec di
cmp di,[YnowPr]
jnz @@DoThisY

push ax
	; show mouse
		mov ax,01h
		int 33h
pop ax

popa


pop es
ret
endp BackTOBgColor

;moves to al the bg color
proc GetBgColor
	push bx
	push cx
	push dx
	
	mov ah,0dh
	mov bh,0
	mov cx,[XNowPr]
	inc cx
	;add cx,2
	mov dx,[YnowPr]
	inc dx
	;add dx,2
	int 10h

	
	pop dx
	pop cx
	pop bx
ret
endp GetBgColor

;================================================
; Description: draw pixels on screen that wil make a cut on fruit
; Input: cx,dx
; Output: on screen
; Changes: 
;================================================
proc DrawCut
	; hide mouse
		push ax
		mov ax,02h
		int 33h
		pop ax

push dx
push cx
push bx
push ax	

		sub dx,1
		
		mov ah, 0ch
		mov bh,0
		int 10h
		
		inc dx
		dec cx
		
		mov ah, 0ch
		mov bh,0
		int 10h
		
		inc cx
		
		mov ah, 0ch
		mov bh,0
		int 10h
		
		inc cx
		
		mov ah, 0ch
		mov bh,0
		int 10h
		
		dec cx
		inc dx
		
		mov ah, 0ch
		mov bh,0
		int 10h
		
pop ax
pop bx
pop cx
pop dx 
		
		; show mouse
		push ax
		mov ax,01h
		int 33h
		pop ax
ret
endp DrawCut




 

proc _25MicroSecDelay
	push  cx
	push dx
	push ax


	mov     cx, 00h
	mov     dx, 46A0h
	mov     ah, 86h
	int     15h

	pop ax
	pop dx
	pop cx
	
	ret
endp _25MicroSecDelay
 
proc setKnifeMouse
	; next 5 lines are  not must, only if u want to  re draw the mouse
	 mov ax,ds
	 mov es,ax
	 mov  BX,0      ;software pointer
	 mov  CX,0     ;mask all current information
 	 mov  dx,offset MouseMask     ;1xxx=blue bkgd, x4xx=red frgd, xxfb='√'
 	 mov  AX,0009H
 	 int  33H
	 ; see http://www.techhelpmanual.com/842-int_33h_0009h__set_graphics_pointer_shape.html
ret
endp setKnifeMouse

 
proc setAsyncMouse 

   ;set graphic 
	push ds
	pop  es
	
	 mov ax, seg TapChecker 
     mov es, ax
     mov dx, offset TapChecker   ; ES:DX ->Far routine
     mov ax,0Ch             ; interrupt number
     mov cx,0FFh             ; all oitions make it work
     int 33h                
	 ; see http://www.techhelpmanual.com/845-int_33h_000ch__set_mouse_event_handler.html
				
	
	 ; next 5 lines are  not must, only if u want to  re draw the mouse
	 ; mov ax,ds
	 ; mov es,ax
	 ; mov  BX,0      ;software pointer
	 ; mov  CX,0     ;mask all current information
 	 ; mov  dx,offset MouseMask     ;1xxx=blue bkgd, x4xx=red frgd, xxfb='√'
 	 ; mov  AX,0009H
 	 ; int  33H
	 ; see http://www.techhelpmanual.com/842-int_33h_0009h__set_graphics_pointer_shape.html
	 
	ret
endp setAsyncMouse


;This proc is Async proc - 
; It will be registered using in33h (0ch) 
; then, each time when Mouse event will occur it will be called by mouse program (and OS).
PROC TapChecker  far
stop:
pusha
		; push cx  ;make musk to 0
		; push ax
		; mov ax,0ch
		; mov cx,0
		; int 33h
		; pop ax
		; pop cx
		
		push es
		
		push 0A000h  ; in order to write directly to video memory we must set es the address
		pop es
		
		 
		; show mouse
		; push ax
		; mov ax,01h
		; int 33h	
		; pop ax
		
		
		
		shr cx, 1 	 ;the Mouse default is 640X200 So divide 640 by 2 to get
		
		
		cmp dx,21
		ja @@DoCut
		; cmp bx,1
		; jne @@CheckTap
		cmp cx,147
		jb @@CheckTap
		cmp cx,173
		ja @@CheckTap
		cmp bx,2
		je @@ChackChaneStat
		cmp bx,1
		je @@ChangeState
		jmp @@CheckTap
@@ChangeState:
	cmp [Pflag],0
	je @@PauseGame
	cmp [Pflag],1
	je @@ResumeGame
	cmp [Pflag],2
	je @@ExitGame
@@ResumeGame: 
	mov [Pflag],0
	call PutStatusOnScreen
	jmp @@CheckTap
@@PauseGame:
	mov [Pflag],1
	call PutStatusOnScreen
	;mov [PfalgOut],1
	;jmp @@CheckTap
	jmp @@CheckTap
@@ExitGame:
	mov [PfalgOut],1
	jmp @@done
	
	
@@ChackChaneStat:	;need to jump to @@CheckTap after finishing if not it will draw a cut
	cmp [Pflag],1
	je @@ToExit
	cmp [Pflag],2
	je @@ToResume
	jmp @@CheckTap
	
@@ToExit:
	mov [Pflag],2
	call PutStatusOnScreen
	jmp @@CheckTap
@@ToResume:	
	mov [Pflag],1
	call PutStatusOnScreen
	jmp @@CheckTap
	
	
	
		; cmp cx,94
		; ja @@CheckMore
		; jmp @@CheckTap
; @@CheckMore:
		; cmp cx,234
		; jb @@DoCut
		; jmp @@CheckTap
		
@@DoCut:		
		call GetBgColor
		
		call DrawCut
@@CheckTap:
		
		cmp [pflag],1
		je @@dont
		cmp cx,[XNowPr]
		jb @@dont
		cmp cx,[EndXNowPr]
		ja @@dont
		cmp dx,[YNowPr]
		jb @@dont
		cmp dx,[EndYNowPr]
		ja @@dont
		inc [CntTaped]
		jmp @@done
		
		
@@dont:		
		jmp @@done

@@done:		
		; show mouse
		; mov ax,01h
		; int 33h	
		
		pop es
		
		; push cx   ;return to mask
		; push ax
		; mov ax,0ch
		; mov cx,0FFh
		; int 33h
		; pop ax
		; pop cx
popa
		retf
ENDP TapChecker

proc _400MiliSecDelay
	call _200MiliSecDelay
	call _200MiliSecDelay
	ret
endp _400MiliSecDelay 
     
proc _200MiliSecDelay
	push cx
	
	mov cx ,1000 
@@Self1:
	
	push cx
	mov cx,600 

@@Self2:	
	loop @@Self2
	
	pop cx
	loop @@Self1
	
	pop cx
	ret
endp _200MiliSecDelay


; Sync wait for mouse click
; proc WaitTillGotClickOnSomePoint
	; push si
	; push ax
	; push bx
	; push cx
	; push dx
	
	; mov ax,1
	; int 33h
	
	
; ClickWaitWithDelay:
	; mov cx,1000
; @@ag:	
	; loop @@ag
; WaitTillPressOnPoint:

	; mov ax,5h
	; mov bx,0 ; quary the left b
	; int 33h
	
	
	; cmp bx,00h
	; jna ClickWaitWithDelay  ; mouse wasn't pressed
	; and ax,0001h
	; jz ClickWaitWithDelay   ; left wasn't pressed

 	
	; shr cx,1
	; cmp cx,250
	; ja ClickForExit
	; mov si, cx 
	; add si, [SquareSize]
	; cmp si , [Xclick]
	; jl WaitTillPressOnPoint
	; mov si, cx 
	; sub si, [SquareSize]
	; cmp si , [Xclick]
	; jg WaitTillPressOnPoint
	
	
	; mov si, dx 
	; add si, [SquareSize]
	; cmp si , [Yclick]
	; jl WaitTillPressOnPoint
	; mov si, dx 
	; sub si, [SquareSize]
	; cmp si , [Yclick]
	; jg WaitTillPressOnPoint
	; mov [GotClick],1
	; jmp @@EndProc
; ClickForExit:	
	; mov [GotClick],0
; @@EndProc:
	; mov ax,2
	; int 33h
	
	; pop dx
	; pop cx
	; pop bx
	; pop ax
	; pop si
	; ret
; endp WaitTillGotClickOnSomePoint









proc setTextMode near
	mov ax,2 ;back to text mode
	int 10h
	ret
endp setTextMode


proc OpenShowBmp near
	
	 
	call OpenBmpFile
	cmp [ErrorFile],1
	je @@ExitProc
	
	call ReadBmpHeader
	
	call ReadBmpPalette
	
	call CopyBmpPalette
	
	call  ShowBmp
	
	 
	call CloseBmpFile

@@ExitProc:
	ret
endp OpenShowBmp

 



; The Screen BitMap and save it into a new bmp file
; the header and palette will be same like the the file that we read before
; So , sometimes we will see color differences between screen and file. 
; proc SaveVgaMemToFile near
	
	; lea dx, [FileNameOut]
	; call CreateBmpFile
	; cmp [ErrorFile],1
	; je @@ExitProc
	
	; call PutBmpHeader
	
	; call PutBmpPalette
	
	; call PutBmpDataIntoFile
	
	; call CloseBmpFile

; @@ExitProc:
	; ret
; endp SaveVgaMemToFile

	
; input dx filename to open
proc OpenBmpFile	near						 
	mov ah, 3Dh
	xor al, al
	int 21h
	jc @@ErrorAtOpen
	mov [FileHandle], ax
	jmp @@ExitProc
	
@@ErrorAtOpen:
	mov [ErrorFile],1
@@ExitProc:	
	ret
endp OpenBmpFile

	
; output file dx filename to open
proc CreateBmpFile	near						 
	 
	
CreateNewFile:
	mov ah, 3Ch 
	mov cx, 0 
	int 21h
	
	jnc Success
@@ErrorAtOpen:
	mov [ErrorFile],1
	jmp @@ExitProc
	
Success:
	mov [ErrorFile],0
	mov [FileHandle], ax
@@ExitProc:
	ret
endp CreateBmpFile





proc CloseBmpFile near
	mov ah,3Eh
	mov bx, [FileHandle]
	int 21h
	ret
endp CloseBmpFile




; Read 54 bytes the Header
proc ReadBmpHeader	near					
	push cx
	push dx
	
	mov ah,3fh
	mov bx, [FileHandle]
	mov cx,54
	mov dx,offset Header
	int 21h
	
	pop dx
	pop cx
	ret
endp ReadBmpHeader



proc ReadBmpPalette near ; Read BMP file color palette, 256 colors * 4 bytes (400h)
						 ; 4 bytes for each color BGR + null)			
	push cx
	push dx
	
	mov ah,3fh
	mov cx,400h
	mov dx,offset Palette
	int 21h
	
	pop dx
	pop cx
	
	ret
endp ReadBmpPalette


; Will move out to screen memory the colors
; video ports are 3C8h for number of first color
; and 3C9h for all rest
proc CopyBmpPalette		near					
										
	push cx
	push dx
	
	mov si,offset Palette
	mov cx,256
	mov dx,3C8h
	mov al,0  ; black first							
	out dx,al ;3C8h
	inc dx	  ;3C9h
CopyNextColor:
	mov al,[si+2] 		; Red				
	shr al,2 			; divide by 4 Max (cos max is 63 and we have here max 255 ) (loosing color resolution).				
	out dx,al 						
	mov al,[si+1] 		; Green.				
	shr al,2            
	out dx,al 							
	mov al,[si] 		; Blue.				
	shr al,2            
	out dx,al 							
	add si,4 			; Point to next color.  (4 bytes for each color BGR + null)				
								
	loop CopyNextColor
	
	pop dx
	pop cx
	
	ret
endp CopyBmpPalette

proc ShowBMP 
; BMP graphics are saved upside-down.
; Read the graphic line by line (BmpRowSize lines in VGA format),
; displaying the lines from bottom to top.
	push cx
	
	mov ax, 0A000h
	mov es, ax
	
	mov cx,[BmpRowSize]
	
 
	mov ax,[BmpColSize] ; row size must dived by 4 so if it less we must calculate the extra padding bytes
	xor dx,dx
	mov si,4
	div si
	cmp dx,0
	mov bp,0
	jz @@row_ok
	mov bp,4
	sub bp,dx

@@row_ok:	
	mov dx,[BmpLeft]
	
@@NextLine:
	push cx
	push dx
	
	mov di,cx  ; Current Row at the small bmp (each time -1)
	add di,[BmpTop] ; add the Y on entire screen
	
 
	; next 5 lines  di will be  = cx*320 + dx , point to the correct screen line
	mov cx,di
	shl cx,6
	shl di,8
	add di,cx
	add di,dx
	 
	; small Read one line
	mov ah,3fh
	mov cx,[BmpColSize]  
	add cx,bp  ; extra  bytes to each row must be divided by 4
	mov dx,offset ScrLine
	int 21h
	; Copy one line into video memory
	cld ; Clear direction flag, for movsb
	mov cx,[BmpColSize]  
	mov si,offset ScrLine
	rep movsb ; Copy line to the screen
	
	pop dx
	pop cx
	 
	loop @@NextLine
	
	pop cx
	ret
endp ShowBMP 

	

; Read 54 bytes the Header
proc PutBmpHeader	near					
	mov ah,40h
	mov bx, [FileHandle]
	mov cx,54
	mov dx,offset Header
	int 21h
	ret
endp PutBmpHeader
 



proc PutBmpPalette near ; Read BMP file color palette, 256 colors * 4 bytes (400h)
						 ; 4 bytes for each color BGR + null)			
	mov ah,40h
	mov cx,400h
	mov dx,offset Palette
	int 21h
	ret
endp PutBmpPalette


 
proc PutBmpDataIntoFile near
			
    mov dx,offset OneBmpLine  ; read 320 bytes (line) from file to buffer
	
	mov ax, 0A000h ; graphic mode address for es
	mov es, ax
	
	mov cx,BMP_HEIGHT
	
	cld 		; forward direction for movsb
@@GetNextLine:
	push cx
	dec cx
										 
	mov si,cx    ; set si at the end of the cx line (cx * 320) 
	shl cx,6	 ; multiply line number twice by 64 and by 256 and add them (=320) 
	shl si,8
	add si,cx
	
	mov cx,BMP_WIDTH    ; line size
	mov di,dx
    
	 push ds 
     push es
	 pop ds
	 pop es
	 rep movsb
	 push ds 
     push es
	 pop ds
	 pop es
 
	
	
	 mov ah,40h
	 mov cx,BMP_WIDTH
	 int 21h
	
	 pop cx ; pop for next line
	 loop @@GetNextLine
	
	
	
	 ret 
endp PutBmpDataIntoFile

proc DrawHorizontalLine	near
	push si
	push cx
DrawLine:
	cmp si,0
	jz ExitDrawLine	
	 
    mov ah,0ch	
	int 10h    ; put pixel
	 
	
	inc cx
	dec si
	jmp DrawLine
	
	
ExitDrawLine:
	pop cx
    pop si
	ret
endp DrawHorizontalLine



proc DrawVerticalLine	near
	push si
	push dx
 
DrawVertical:
	cmp si,0
	jz @@ExitDrawLine	
	 
    mov ah,0ch	
	int 10h    ; put pixel
	
	 
	
	inc dx
	dec si
	jmp DrawVertical
	
	
@@ExitDrawLine:
	pop dx
    pop si
	ret
endp DrawVerticalLine

; cx = col dx= row al = color si = height di = width 
proc Rect
	push cx
	push di
NextVerticalLine:	
	
	cmp di,0
	jz @@EndRect
	
	cmp si,0
	jz @@EndRect
	call DrawVerticalLine
	inc cx
	dec di
	jmp NextVerticalLine
	
	
@@EndRect:
	pop di
	pop cx
	ret
endp Rect



; proc DrawSquare
	; push si
	; push ax
	; push cx
	; push dx
	
	; mov al,[Color]
	; mov si,[SquareSize]  ; line Length
 	; mov cx,[Xp]
	; mov dx,[Yp]
	; call DrawHorizontalLine

	 
	
	; call DrawVerticalLine
	 
	
	; add dx ,si
	; dec dx
	; call DrawHorizontalLine
	 
	
	
	; sub  dx ,si
	; inc dx
	; add cx,si
	; dec cx
	; call DrawVerticalLine
	
	
	 ; pop dx
	 ; pop cx
	 ; pop ax
	 ; pop si
	 
	; ret
; endp DrawSquare

proc  SetGraphic
	mov ax,13h   ; 320 X 200 
				 ;Mode 13h is an IBM VGA BIOS mode. It is the specific standard 256-color mode 
	int 10h
	ret
endp 	SetGraphic

proc LoopDelay1Sec
	push cx
	
	mov cx ,1000 
@@Self1:
	
	push cx
	mov cx,3000 

@@Self2:	
	loop @@Self2
	
	pop cx
	loop @@Self1
	
	pop cx
	ret
	
endp LoopDelay1Sec

proc LoopDelayHalfSec
	push cx
	
	mov cx ,500 
@@Self1:
	
	push cx
	mov cx,3000 

@@Self2:	
	loop @@Self2
	
	pop cx
	loop @@Self1
	
	pop cx
	ret
	
endp LoopDelayHalfSec

proc LoopDelayQuarterSec
	push cx
	
	mov cx ,250 
@@Self1:
	
	push cx
	mov cx,3000 

@@Self2:	
	loop @@Self2
	
	pop cx
	loop @@Self1
	
	pop cx
	ret
	
endp LoopDelayQuarterSec

proc LoopDelayEightheSec
push cx
	
	mov cx ,125 
@@Self1:
	
	push cx		
	mov cx,3000 

@@Self2:	
	loop @@Self2
	
	pop cx
	loop @@Self1
	
pop cx
ret
	
endp LoopDelayEightheSec

proc LoopSmallDelay
push cx
	
	mov cx ,60 
@@Self1:
	
	push cx		
	mov cx,3000 
	sub cx,[score]
	cmp cx,500
	ja @@continue
	mov cx,500
@@continue:	

@@Self2:	
	loop @@Self2
	
	pop cx
	loop @@Self1
	
pop cx
ret
endp LoopSmallDelay

proc printAxDec  
	   
       push bx
	   push dx
	   push cx
	           	   
       mov cx,0   ; will count how many time we did push 
       mov bx,10  ; the divider
   
put_next_to_stack:
       xor dx,dx
       div bx
       add dl,30h
	   ; dl is the current LSB digit 
	   ; we cant push only dl so we push all dx
       push dx    
       inc cx
       cmp ax,9   ; check if it is the last time to div
       jg put_next_to_stack

	   cmp ax,0
	   jz pop_next_from_stack  ; jump if ax was totally 0
       add al,30h  
	   mov dl, al    
  	   mov ah, 2h
	   int 21h        ; show first digit MSB
	       
pop_next_from_stack: 
       pop ax    ; remove all rest LIFO (reverse) (MSB to LSB)
	   mov dl, al
       mov ah, 2h
	   int 21h        ; show all rest digits
       loop pop_next_from_stack

	   pop cx
	   pop dx
	   pop bx
	   
       ret
endp printAxDec   

proc ShowAxDecimal
	   push ax
       push bx
	   push cx
	   push dx
	   
	   ; check if negative
	   test ax,08000h
	   jz PositiveAx
			
	   ;  put '-' on the screen
	   push ax
	   mov dl,'-'
	   mov ah,2
	   int 21h
	   pop ax

	   neg ax ; make it positive
PositiveAx:
       mov cx,0   ; will count how many time we did push 
       mov bx,10  ; the divider
   
put_mode_to_stack:
       xor dx,dx
       div bx
       add dl,30h
	   ; dl is the current LSB digit 
	   ; we cant push only dl so we push all dx
       push dx    
       inc cx
       cmp ax,9   ; check if it is the last time to div
       jg put_mode_to_stack

	   cmp ax,0
	   jz pop_next  ; jump if ax was totally 0
       add al,30h  
	   mov dl, al    
  	   mov ah, 2h
	   int 21h        ; show first digit MSB
	       
pop_next: 
       pop ax    ; remove all rest LIFO (reverse) (MSB to LSB)
	   mov dl, al
       mov ah, 2h
	   int 21h        ; show all rest digits
       loop pop_next
		
	   mov dl, ','
       mov ah, 2h
	   int 21h
   
	   pop dx
	   pop cx
	   pop bx
	   pop ax
	   
	   ret
endp ShowAxDecimal

; put some data in Code segment in order to have enough bytes to xor with 
	SomeRNDData	    db 227	,111	,105	,1		,127
					db 234	,6		,116	,101	,220
					db 92	,60		,21		,228	,22
					db 222	,63		,216	,208	,146
					db 60	,172	,60		,80		,30
					db 23	,85		,67		,157	,131
					db 120	,111	,105	,49		,107
					db 148	,15		,141	,32		,225
					db 113	,163	,174	,23		,19
					db 143	,28		,234	,56		,74
					db 223	,88		,214	,122	,138
					db 100	,214	,161	,41		,230
					db 8	,93		,125	,132	,129
					db 175	,235	,228	,6		,226
					db 202	,223	,2		,6		,143
					db 8	,147	,214	,39		,88
					db 130	,253	,106	,153	,147
					db 73	,140	,251	,32		,59
					db 92	,224	,138	,118	,200
					db 244	,4		,45		,181	,62
					
					
	; Description  : get RND between any bl and bh includs (max 0 -255)
; Input        : 1. Bl = min (from 0) , BH , Max (till 255)
; 			     2. RndCurrentPos a  word variable,   help to get good rnd number
; 				 	Declre it at DATASEG :  RndCurrentPos dw ,0
;				 3. EndOfCsLbl: is label at the end of the program one line above END start		
; Output:        Al - rnd num from bl to bh  (example 50 - 150)
; More Info:
; 	Bl must be less than Bh 
; 	in order to get good random value again and agin the Code segment size should be 
; 	at least the number of times the procedure called at the same second ... 
; 	for example - if you call to this proc 50 times at the same second  - 
; 	Make sure the cs size is 50 bytes or more 
; 	(if not, make it to be more) 
proc RandomByCs
    push es
	push si
	push di
	
	mov ax, 40h
	mov	es, ax
	
	sub bh,bl  ; we will make rnd number between 0 to the delta between bl and bh
			   ; Now bh holds only the delta
	cmp bh,0
	jz @@ExitP
 
	mov di, [word RndCurrentPos]
	call MakeMask ; will put in si the right mask according the delta (bh) (example for 28 will put 31)
	
RandLoop: ;  generate random number 
	mov ax, [es:06ch] ; read timer counter
	mov ah, [byte cs:di] ; read one byte from memory (from semi random byte at cs)
	xor al, ah ; xor memory and counter
	
	; Now inc di in order to get a different number next time
	inc di
	cmp di,(EndOfCsLbl - start - 1)
	jb @@Continue
	mov di, offset start
@@Continue:
	mov [word RndCurrentPos], di
	
	and ax, si ; filter result between 0 and si (the nask)
	cmp al,bh    ;do again if  above the delta
	ja RandLoop
	
	add al,bl  ; add the lower limit to the rnd num
		 
@@ExitP:	
	pop di
	pop si
	pop es
	ret
endp RandomByCs


; Description  : get RND between any bl and bh includs (max 0 -255)
; Input        : 1. BX = min (from 0) , DX, Max (till 64k -1)
; 			     2. RndCurrentPos a  word variable,   help to get good rnd number
; 				 	Declre it at DATASEG :  RndCurrentPos dw ,0
;				 3. EndOfCsLbl: is label at the end of the program one line above END start		
; Output:        AX - rnd num from bx to dx  (example 50 - 1550)
; More Info:
; 	BX  must be less than DX 
; 	in order to get good random value again and again the Code segment size should be 
; 	at least the number of times the procedure called at the same second ... 
; 	for example - if you call to this proc 50 times at the same second  - 
; 	Make sure the cs size is 50 bytes or more 
; 	(if not, make it to be more) 
proc RandomByCsWord
    push es
	push si
	push di
 
	
	mov ax, 40h
	mov	es, ax
	
	sub dx,bx  ; we will make rnd number between 0 to the delta between bl and bh
			   ; Now bh holds only the delta
	cmp dx,0
	jz @@ExitP
	
	push bx
	
	mov di, [word RndCurrentPos]
	call MakeMaskWord ; will put in si the right mask according the delta (bh) (example for 28 will put 31)
	
@@RandLoop: ;  generate random number 
	mov bx, [es:06ch] ; read timer counter
	
	mov ax, [word cs:di] ; read one word from memory (from semi random bytes at cs)
	xor ax, bx ; xor memory and counter
	
	; Now inc di in order to get a different number next time
	inc di
	inc di
	cmp di,(EndOfCsLbl - start - 2)
	jb @@Continue
	mov di, offset start
@@Continue:
	mov [word RndCurrentPos], di
	
	and ax, si ; filter result between 0 and si (the nask)
	
	cmp ax,dx    ;do again if  above the delta
	ja @@RandLoop
	pop bx
	add ax,bx  ; add the lower limit to the rnd num
		 
@@ExitP:
	
	pop di
	pop si
	pop es
	ret
endp RandomByCsWord

; make mask acording to bh size 
; output Si = mask put 1 in all bh range
; example  if bh 4 or 5 or 6 or 7 si will be 7
; 		   if Bh 64 till 127 si will be 127
Proc MakeMask    
    push bx

	mov si,1
    
@@again:
	shr bh,1
	cmp bh,0
	jz @@EndProc
	
	shl si,1 ; add 1 to si at right
	inc si
	
	jmp @@again
	
@@EndProc:
    pop bx
	ret
endp  MakeMask


Proc MakeMaskWord    
    push dx
	
	mov si,1
    
@@again:
	shr dx,1
	cmp dx,0
	jz @@EndProc
	
	shl si,1 ; add 1 to si at right
	inc si
	
	jmp @@again
	
@@EndProc:
    pop dx
	ret
endp  MakeMaskWord



; get RND between bl and bh includs
; output al - rnd num from bl to bh
; the distance between bl and bh  can't be greater than 100 
; Bl must be less than Bh 
; proc RndBlToBh  ; by Dos  with delay
	; push  cx
	; push dx
	; push si 


	; mov     cx, 1h
	; mov     dx, 0C350h
	; mov     ah, 86h
	; int     15h   ; Delay of 50k micro sec
	
	; sub bh,bl
	; cmp bh,0
	; jz @@EndProc
	
	; call MakeMask ; will put in si the right mask (example for 28 will put 31)
; RndAgain:
	; mov ah, 2ch   
	; int 21h      ; get time from MS-DOS
	; mov ax, dx   ; DH=seconds, DL=hundredths of second
	; and ax, si  ;  Mask for Highst num in range  
	; cmp al,bh    ; we deal only with al (0  to 100 )
	; ja RndAgain
 	
	; add al,bl

; @@EndProc:
	; pop si
	; pop dx
	; pop cx
	
	; ret
; endp RndBlToBh

; input [BmpColSize] , [BmpRowSize] , dx-offset photo
; proc SimpleThrow
	; push di
	; push si
	; push cx
	; push bx
	; push ax
	
; @@StartSimpleThrow:
	; push dx
	; sub [XNowPr],160
	
	; mov ax,[XNowPr]
	; mov bx,[XNowPr]
	
	; mul bx   ;X^2
	
	; div [Aparabola] ;/Aparabola
	
	; mov [YNowPr],ax ;=YNowPr     
	
	; add [XNowPr],160
	
	; mov dx,[XNowPr]
	; mov [BmpLeft],dx
	; mov dx,[YNowPr]   ;set for printing fuit
	; mov [BmpTop],dx
	; mov bl,[Cparabola]
	; mov bh,0
	; add [BmpTop],bx   ;add C of prabola
	
	; add dx,[BmpRowSize]
	; mov bx,dx
	; pop dx
	; call OpenShowBmp
	; call  LoopDelay1Sec
	; add [XNowPr],1    ;next x should be bigger
	
	; cmp bx,200
	; jb @@StartSimpleThrow
	; inc [cntfloor]
	
	; cmp [cntfloor],2
	; jb @@StartSimpleThrow
	; mov [cntfloor],0
	
	
	
	; pop ax
	; pop bx
	; pop cx
	; pop si
	; pop di
; ret
; endp SimpleThrow

; proc FillLast
; push es
		
		; push 0A000h  ; in order to write directly to video memory we must set es the address
		; pop es
; push di
; push si
; push dx
; push cx
; push bx
; push ax			
; mov di,53
; @@DoThisY:
; mov dx,di
; add dx,[lastLeft]
; mov si,68
; @@DoThisX:
; mov cx,si
; add cx,[lastTop]
; mov ah, 0ch
; mov al,[color]
; mov bx,0
; int 10h
; dec si
; cmp si,0
; jnz @@DoThisX
; dec di
; cmp di,0
; jnz @@DoThisY
; pop ax
; pop bx
; pop cx
; pop dx
; pop si
; pop di


; pop es
; ret
; endp FillLast

; proc BgColor
; push es
		
		; push 0A000h  ; in order to write directly to video memory we must set es the address
		; pop es

; pusha		
; mov di,200
; @@DoThisY:
; mov dx,di
; mov si,320
; @@DoThisX:
; mov cx,si
; mov ah, 0ch
; mov al,[color]
; mov bx,0
; int 10h
; dec si
; cmp si,0
; jnz @@DoThisX
; dec di
; cmp di,0
; jnz @@DoThisY
; popa




; pop es
; ret
; endp BgColor



EndOfCsLbl:
END start
