opcodes
byteSwappedNopOpcode
	"For the Tsts class which keeps filling BitMaps with nop, provide one swapped so it turns out correct when disassembled
	mov r0, r0 swapped -> "
	^ 16r00000A0E1