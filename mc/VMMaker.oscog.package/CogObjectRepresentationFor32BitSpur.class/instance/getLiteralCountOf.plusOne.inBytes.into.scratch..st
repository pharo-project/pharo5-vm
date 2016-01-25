compile abstract instructions
getLiteralCountOf: methodReg plusOne: plusOne inBytes: inBytes into: litCountReg scratch: scratchReg
	"Get the literal count of a CompiledMethod into headerReg, plus one if requested.
	  If inBytes is true, scale the count by the word size.  Deal with the possibility of
	 the method being cogged."
	self genGetMethodHeaderOf: methodReg into: litCountReg scratch: scratchReg.
	inBytes
		ifTrue:
			[cogit
				AndCq: coInterpreter alternateHeaderNumLiteralsMask << 1 R: litCountReg;
				LogicalShiftLeftCq: 1 R: litCountReg]
		ifFalse:
			[cogit
				LogicalShiftRightCq: 1 R: litCountReg;
				AndCq: coInterpreter alternateHeaderNumLiteralsMask R: litCountReg].
	plusOne ifTrue:
		[cogit AddCq: (inBytes ifTrue: [objectMemory wordSize] ifFalse: [1]) R: litCountReg].
	^0