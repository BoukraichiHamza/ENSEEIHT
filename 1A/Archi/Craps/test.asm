add %r1, 10, %r1
st  %r1, [%r0+60]
st  %r0, [%r0+%r1]

ld [%r0+%r1], %r1
ld [%r0+60], %r1

loop :
sub %r1, %r20, %r1
tst %r1
bne loop
