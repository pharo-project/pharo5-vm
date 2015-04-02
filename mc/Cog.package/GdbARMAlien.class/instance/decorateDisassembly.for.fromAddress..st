disassembly
decorateDisassembly: anInstructionString for: aSymbolManager fromAddress: address
"Decode what we can of the instruction and decorate it with useful stuff"
	| word opcode rotate mode operand |
	word := aSymbolManager objectMemory longAt: address.
	(self instructionIsAnyB: word)
		ifTrue:
			[((self instructionIsB: word) or: [self instructionIsBL: word])
				ifTrue:["We can extract the offset from a plain B/BL instruction"
					operand := self extractOffsetFromBL: word..
					 operand := operand + address + 8 bitAnd: aSymbolManager addressSpaceMask].
			((self instructionIsBX: word) or: [self instructionIsBLX: word])
				ifTrue:["We can extract the offset from a  BX/BLX instructions register"			
					operand := (self perform: (self registerStateGetters at: (word bitAnd: 15) + 1))]]
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