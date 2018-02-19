	set 78,%r1
	add %r0,%r1,%r3
main: tst %r3       
      bpos loop
      bneg avantfin
      
      

loop : add %r2,%r20,%r2
	sub %r3,10,%r3
       ba main

avantfin : add %r3,10,%r3
           sub %r2,1,%r2
           ba fin

fin : ba fin



