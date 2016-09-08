compile abstract instructions
getLiteralCountOf: methodReg plusOne: plusOne inBytes: inBytes into: litCountReg scratch: scratchReg
	"Get the literal count of a CompiledMethod into headerReg, plus one if requested.
	  If inBytes is true, scale the count by the word size.  Deal with the possibility of
	 the method being cogged."
	self genGetMethodHeaderOf: methodReg into: litCountReg scratch: scratchReg.
	self assert: 1 << objectMemory numTagBits = objectMemory wordSize.
	inBytes
		ifTrue:
			[cogit
				AndCq: coInterpreter alternateHeaderNumLiteralsMask << objectMemory numTagBits
				R: litCountReg]
		ifFalse:
			[cogit
				LogicalShiftRightCq: objectMemory numTagBits R: litCountReg;
				AndCq: coInterpreter alternateHeaderNumLiteralsMask R: litCountReg].
	plusOne ifTrue:
		[cogit
			AddCq: (inBytes
						ifTrue: [LiteralStart * objectMemory wordSize]
						ifFalse: [LiteralStart])
			R: litCountReg].
	^0