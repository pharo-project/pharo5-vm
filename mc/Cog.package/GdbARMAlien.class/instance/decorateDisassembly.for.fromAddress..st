disassembly
decorateDisassembly: anInstructionString for: aSymbolManager fromAddress: address
	| word opcode rotate mode operand |
	word := aSymbolManager objectMemory longAt: address.
	(self instructionIsAnyB: word)
		ifTrue:
			[operand := word bitAnd: 16rFFFFFF.
			 (operand anyMask: 16r800000) ifTrue:
				[operand := operand - 16r1000000].
			 operand := operand * 4 + address + 8 bitAnd: aSymbolManager addressSpaceMask]
		ifFalse:
			[((self instructionIsAnyLoadStore: word)
			  and: [(word >> 16 bitAnd: 15) = CogARMCompiler VarBaseReg])
				ifTrue:
					[operand := aSymbolManager varBaseAddress + (word bitAnd: 1 << 12 - 1)]
				ifFalse:
					[opcode := word >> 21 bitAnd: 16rF.
					 opcode ~= CogARMCompiler orOpcode ifTrue:
						[^anInstructionString].
					 rotate := word >> 8 bitAnd: 16rF.
					 mode := word >> 25 bitAnd: 7.
					 "CogARMCompiler always uses a 0 rotate in the last operand of the final ORR when building long constants."
					 (mode = 1 and: [rotate ~= 0]) ifTrue:
						[^anInstructionString].
					 operand := aSymbolManager backEnd literalBeforeFollowingAddress: address + 4]].
	"is there an intersting address with this?"
	^(aSymbolManager lookupAddress: operand)
		ifNotNil: [:string| anInstructionString, ' = ', (operand printStringRadix: 16), ' = ', string]
		ifNil: [anInstructionString, ' = ', (operand printStringRadix: 16)]