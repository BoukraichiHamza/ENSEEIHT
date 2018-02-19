	set 27, %r1
	set 0,%r2
	set 0x80000000,%r3
	
main1: 
	and %r1,%r3,%r4
	tst %r4
	bne incr
	beq main2

main2 : add %r1,%r1,%r1
	 tst %r1
	 bne main1
	 beq fin

incr : add %r2,1,%r2
	ba main2

fin : ba fin