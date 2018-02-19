	set 0x200,%r29
	set 0,%r2
	set 0,%r3
	set 0x100,%r1
	 

main1 : ld [%r1+%r2],%r6 
        add %r2,1,%r2
	  tst %r6
        bne main1
         
main2 : sub %r2,2,%r2

main3 :ld [%r1+%r2],%r6
	 ld [%r1+%r3],%r7
       st %r6,[%r1+%r3]
	st %r7,[%r1+%r2]
	sub %r2,1,%r2
	add %r3,1,%r3
	sub %r2,%r3,%r8
	tst %r8
	bpos main3
	bneg end

end : ba end
 



      .org    0x100
TAB:  .word   9, 5, 6, 2, 10 , 0