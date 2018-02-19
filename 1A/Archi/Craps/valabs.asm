	set  -1, %r1
	tst %r1
	bneg neg
	bpos pos
      ba fin

neg : sub %r0,%r1,%r2
      ba fin

pos : 	mov  %r1,%r2
      ba fin

fin : ba fin
