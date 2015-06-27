disassembly
decorateDisassembly: anInstructionString for: aSymbolManager fromAddress: address
"Decode what we can of the instruction and decorate it with useful stuff"
	| word opcode rotate mode operand memory addressinatorBlock|
	addressinatorBlock :=
		[:value| | string |
		(value notNil
		 and: [(string := aSymbolManager lookupAddress: value) notNil])
			ifTrue: [ ' = ', value hex, ' = ', string]
			ifFalse: ['']].
	
	word := (memory:= aSymbolManager objectMemory) longAt: address.
	(self instructionIsAnyB: word)
		ifTrue:
			[((self instructionIsB: word) or: [self instructionIsBL: word]) ifTrue:
				["We can extract the offset from a plain B/BL instruction"
				 operand := self extractOffsetFromBL: word..
				 operand := operand + address + 8 bitAnd: aSymbolManager addressSpaceMask].
			"We can't extract the offset from a  BX/BLX instructions register, unless we're at the current pc,
			 because otherwise its current value has nothing to do with the value when this instruction is executed."
			(self pc = address
			 and: [(self instructionIsBX: word) or: [self instructionIsBLX: word]]) ifTrue:
					[operand := (self perform: (self registerStateGetters at: (word bitAnd: 15) + 1))]]
		ifFalse:
			[(self instructionIsAnyLoadStore: word)
				ifTrue:
					[|baseR lit|
					"first see if this is a load via the varBase register - quick access globals. We'll trust
					that nobody makes a nasty instruction that uses this reg in a mean way" 
					operand := (baseR := (word >> 16 bitAnd: 15)) = CogARMCompiler VarBaseReg
									ifTrue: [aSymbolManager varBaseAddress + (word bitAnd: 1 << 12 - 1)]
									ifFalse: [self pc = address ifTrue:
												[(self register: baseR) + (self extractOffsetFromLoadStore: word)]].
					"See if this is a pc-relative literal load"
					baseR = CogARMCompiler PCReg ifTrue:
						[lit := memory longAt: (aSymbolManager backEnd pcRelativeAddressAt: address).
						 ^(aSymbolManager lookupAddress: lit)
							ifNotNil: [:label| anInstructionString, ' ', label]
							ifNil: [anInstructionString, ' ', lit hex]].
					"look for SP operations -pop/push"
					 (self instructionIsPush: word) ifTrue: "push - "
						[|srcR|
						srcR := word >>12 bitAnd: 16rF.
						^ (anInstructionString readStream upTo: $}), '}', (self pc = address ifTrue: ['  (', (self register: srcR) hex, ') to ',  (self sp - 4) hex] ifFalse: [''])].
					(self instructionIsPop: word) ifTrue: "pop - " 
						[^ (anInstructionString readStream upTo: $}), '}', (self pc = address ifTrue: ['  (', (memory longAt: self sp) hex, ') ' , ' from ' , self sp hex] ifFalse: [''])].

					"look for a ld/st of the sp"
					(self instructionIsLDRSP: word) ifTrue:
						[^anInstructionString, '; Load SP from ', (addressinatorBlock value: operand)].
					(self instructionIsSTRSP: word) ifTrue:
						[^anInstructionString, '; Save SP to ', (addressinatorBlock value: operand)]]
				ifFalse:
					["check for SP changers not relating to read/writing data"
					 (self instructionIsAlignSP: word) ifTrue:
						[^anInstructionString, ' ALIGN SP ', (self pc = address ifTrue: [self sp hex] ifFalse: [''])].
					 (self instructionIsAddSP: word) ifTrue:
						[^anInstructionString, ' ADD ', (word bitAnd: 16rFF) asString,' to SP ', (self pc = address ifTrue: ['= ' , self sp hex] ifFalse: [''])].

					 "check for the end of a mov/orr/orr/orr set filling a reg with a const"
					 opcode := word >> 21 bitAnd: 16rF.
					 (opcode ~= CogARMCompiler orOpcode
					  or: [aSymbolManager cogit backEnd literalLoadInstructionBytes = 4]) ifTrue:
						[^anInstructionString].
					 rotate := word >> 8 bitAnd: 16rF.
					 mode := word >> 25 bitAnd: 7.
					 "CogARMCompiler always uses a 0 rotate in the last operand of the final ORR when building long constants."
					 (mode = 1 and: [rotate ~= 0]) ifTrue:
						[^anInstructionString].
					 operand := aSymbolManager backEnd literalBeforeFollowingAddress: address + 4]].
	"is there an interesting address with this?"
	^anInstructionString, (addressinatorBlock value: operand)