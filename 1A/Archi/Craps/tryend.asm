	ba init

handler :	push %r1
		push %r2
		push %r3
		push %r4
		push %r5
		push %r6
		push %r7
		push %r8
		push %r9
		push %r28
		
		set 0x100,%r8
		
		pop %r28
		pop %r9
		pop %r8
		pop %r7
		pop %r6
		pop %r5
		pop %r4
		pop %r3
		pop %r2
		pop %r1

		reti

init :		set 0xA0000000, %r1
		setq 0b1111, %r2
		st %r2,[%r1+1]
		set 0,%r3
		set 0xB0000000, %r4
		set 0,%r5
		
		set 0x14f,%r6
		set prog2, %r8
		st %r8,[%r6]
		set 0x102,%r6
		set 0x144,%r8
		st %r8,[%r6]
		
		set 0x100,%r8
		set 0,%r7
		st %r7,[%r8]
		
		set 0x101,%r8
		st %29,[%r8]
	
		ba prog1

prog1 :	call delay	
		add %r3,%r20,%r3
		st %r3,[%r1]
		ba prog1

delay :	push %r8
		set 208333 ,%r8

loop : 	subcc %r8,%r20,%r8
 		bne loop
		pop %r8
		ret

prog2 :	call delay
		add %r5,1,%r5
		st %r5,[%r4]
		ba prog2

pwm : 