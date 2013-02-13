movi.d r0 1122
movi.d r1 -646
addi.d r1 r1 -51
add.d r2 r0 r1
and.d r3 r0 r1
cmp r2 r3
brn 4
andi.d r4 r2 741
movi.f r8 -74.79f
movi.f r9 -1214.35f
jsr 25
addi.f r9 r9 66.1f
add.f r10 r8 r9
movi.d r0 9635
movi.d r1 6121
addi.d r0 r0 696
add.d r2 r0 r1
and.d r3 r0 r1
cmp r2 r3
brnz 2
cmpi r2 10000
brp 4
vmovi v0 612.9f
vmov v1 v0
vcompmov v1 0 r8
vcompmov v1 2 r9
vcompmovi v1 1 754.1f
vadd v2 v0 v1
movi.d r0 36
jsrr r0
movi.d r0 1122
movi.d r1 -646
addi.d r1 r1 -51
add.d r2 r0 r1
movi.d r0 48
jmp r0
and.d r3 r0 r1
andi.d r4 r2 741
movi.f r8 -74.79f
movi.f r9 -1214.35f
addi.f r9 r9 66.1f
add.f r10 r8 r9
movi.d r0 9635
movi.d r1 5121
addi.d r0 r0 696
add.d r2 r0 r1
and.d r3 r0 r1
ret