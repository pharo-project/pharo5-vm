debug printing
printFormatForOpcodeName: opcodeName
	"Answer a sequence of $r, $f or nil for the operands in the opcode, used for printing, where
	 r => integer register, f => floating point register, and nil => numeric or address operand.
	 Subclasses can override to provide a format string for their own private opcodes."
	^#()