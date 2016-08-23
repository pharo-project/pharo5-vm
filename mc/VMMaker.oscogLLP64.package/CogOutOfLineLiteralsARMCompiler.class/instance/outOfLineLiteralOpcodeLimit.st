compile abstract instructions
outOfLineLiteralOpcodeLimit
	"The maximum offset in a LDR is (1<<12)-1, or (1<<10)-1 instructions.
	 Be conservative.  The issue is that one abstract instruction can emit
	 multiple hardware instructions so we assume a 2 to 1 worst case of
	 hardware instructions to abstract opcodes.."
	^1 << (12 "12-bit offset field"
			- 2 "4 bytes per literal"
			- 1 "2 hardware instructions to 1 abstract opcode") - 1