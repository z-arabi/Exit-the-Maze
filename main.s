                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors
__Vectors
				DCD  0x20001000     ; stack pointer value when stack is empty
				DCD  Reset_Handler  ; reset vector

				AREA	myCode, CODE, READONLY
				ENTRY
Reset_Handler
	
			; write your code here
			ldr		r0,rownum		; r0 := M[rownum] = 8
			adr		r1,rows			; r1 := rows
					
			sub     r6,r0,#1
			add 	r4,r1,r6,lsl #2	    ;r2,r3,r4,r5 all address
			ldr  	r5,[r4]
			sub     r6,r6,#1
			add 	r5,r5,r6		
			
			add 	r2,r1,#+4	
			ldr  	r3,[r2]
			add 	r3,r3,#+1
			
			add		r10,r0,#+2
			
			LDR		r8,proute
			
			mov		r11,#0
			
		    ldrb	r6,[r3]
			cmp   	r6,#1
			bl 		print
           	bal     endpoint
			
print		STR		r10,[r8]			; M[route] := r2 = 11
			add  	r8,r8,#+4
			mov     r15,r14
					
endpoint	cmp     r2,r4
			bhi		endloop
			bne  	down			
			cmp		r3,r5
			bhi		endloop
			bne		down			
			bl 		print
			bal     endloop
				
down		cmp		r11,#+3
			beq     right
			add 	r7,r2,#+4
			ldrb 	r9,[r3,r0]
			cmp     r9,#1
			bne		right				
			mov     r2,r7
			add     r3,r3,r0
			add		r10,r10,r0
			mov 	r11,#1
			bl		print
			
			
right		cmp	    r11,#4
			beq     up
			add 	r7,r3,#1	
			ldrb    r9,[r7]
			cmp 	r9,#1
			bne		up			
			mov     r3,r7			
			add		r10,r10,#1
			mov     r11,#2
			bl		print
			
up			cmp		r11,#1
			beq     left
			sub 	r7,r2,#4
			sub     r12,r3,r0
			ldrb 	r9,[r12]
			cmp     r9,#1
			bne		left				
			mov     r2,r7
			mov     r3,r12
			sub		r10,r10,r0
			mov 	r11,#3
			bl		print			

			
left		cmp	    r11,#2
			beq     endpoint
			sub 	r7,r3,#1
			ldrb    r9,[r7]
			cmp 	r9,#1
			bne		endpoint			
			mov     r3,r7			
			sub		r10,r10,#1
			mov     r11,#4
			bl      print
			bal		endpoint      		
			
endloop		B		endloop

rownum		DCD		8
rows		DCD		row1,row2,row3,row4,row5,row6,row7,row8
row1		DCB		0,0,0,0,0,0,0,0
row2		DCB		0,1,0,0,1,1,1,0
row3   		DCB		0,1,0,1,1,0,1,0
row4   		DCB		0,1,0,1,0,0,1,0
row5   		DCB		0,1,1,1,0,1,1,0
row6  		DCB		0,0,0,0,0,1,0,0
row7   		DCB		0,0,0,0,0,1,1,0
row8   		DCB		0,0,0,0,0,0,0,0


proute		DCD		route			

			AREA	myData, DATA, READWRITE	
			
route		DCD		0
			
			END
