ba main
	
handler :	push %r4
		ld [%r3],%r4
		add %r4,1,%r4 
		st %r4,[%r3]
		pop %r4
		reti
		

main : 	setq 0x200,%r29
		set 0,%r4
		set 0xA0000000, %r1
		setq 0b1111, %r2
		st %r2,[%r1+1]
		setq 0x100,%r3	
		ba main2

main2 :	ld [%r3],%r4
		st %r4,[%r1] 
		ba main2

	

