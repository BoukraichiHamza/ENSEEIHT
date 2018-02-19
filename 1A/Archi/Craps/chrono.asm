
main :		set 0x200,%r29
		set 0,%r9 //T
		set 0x90000000,%r2
		set 0xA0000000, %r5
		setq 0b1111, %r6
		st %r6,[%r5+1]
		ba stop

 
      
stop : 	set 0b10,%r1
		call swtest
		beq stop10
		bne stopaux

stop10 :	set 0,%r9
		st %r9,[%r5]

stopaux : 	set 0b01,%r1
		call swtest
		beq go
		bne stop		

go :	 	set 0b00,%r1
		call swtest
		beq stop
		bne goautres

goautres :	 call delay
		add %r9,1,%r9
		st %r9,[%r5]
		ba go

//sous programmes

swtest :	push %r2
		set 0x90000000,%r2
		push %r3	
		ld [%r2],%r3
		push %r4
		push %r5
		and %r3,0b11,%r4
		and %r1,0b11,%r5
		subcc %r4,%r5,%r0
		pop %r5
		pop %r4
		pop %r3
		pop %r2
		ret


delay :	push %r8
		set 208333 ,%r8

loop : 	subcc %r8,%r20,%r8
 		bne loop
		pop %r8
		ret

