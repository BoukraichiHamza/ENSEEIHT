set 0xA0000000, %r1
setq 0b1111, %r2
st %r2,[%r1+1]
set 0,%r4

usedelay :	call delay	
		add %r4,%r20,%r4
		st %r4,[%r1]
		ba usedelay




delay :	push %r8
		set 208333 ,%r8

loop : 	subcc %r8,%r20,%r8
 		bne loop
		pop %r8
		ret

