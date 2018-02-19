swtest :
	push %r2
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
