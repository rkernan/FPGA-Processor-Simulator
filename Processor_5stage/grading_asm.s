movi.d r5 3
movi.d r0 0
movi.d r1 16
movi.d r2 1022
ldw r3 r0 0
stw r3 r2 0
addi.d r0 r0 1
addi.d r1 r1 -1
brp -5
addi.d r2 r2 -2
movi.d r0 1023
movi.d r1 255
movi.d r3 -1033
add.d r3 r0 r3
andi.d r6 r0 341
stw r6 r2 0
andi.d r6 r1 85
stw r6 r2 1
andi.d r6 r0 682
stw r6 r2 0
andi.d r6 r1 170
stw r6 r2 1
addi.d r3 r3 1
brn -10
movi.d r0 0
movi.d r1 16
addi.d r5 r5 -1
brzp 1 
jsr 2
movi.d r4 12
jmp r4
movi.d r0 8
movi.d r1 8
ret