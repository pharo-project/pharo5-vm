disassembly
decorateDisassembly: anInstructionString for: aSymbolManager fromAddress: address
"Decode what we can of the instruction and decorate it with useful stuff"
	| word opcode rotate mode operand memory addressinatorBlock|
	addressinatorBlock := [:value|
		(aSymbolManager lookupAddress: value)
		ifNotNil: [:string| ' = ', value hex, ' = ', string]
		ifNil: [' = ', value hex]].
	
	word := (memory:= aSymbolManager objectMemory) longAt: address.
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
			[(self instructionIsAnyLoadStore: word)
				ifTrue: [|baseR|
					"first see if this is a load via the varBase register - quick access globals. We'll trust
					that nobody makes a nasty instruction that uses this reg in a mean way" 
					(baseR := (word >> 16 bitAnd: 15)) = CogARMCompiler VarBaseReg
						ifTrue:[ operand := aSymbolManager varBaseAddress + (word bitAnd: 1 << 12 - 1)]
						ifFalse:[ operand := (self register: baseR) + (self extractOffsetFromLoadStore: word)].

					"look for SP operations -pop/push"
					 (self instructionIsPush: word) ifTrue: ["push - "
						|srcR|
						srcR := word >>12 bitAnd: 16rF.
						^ (anInstructionString readStream upTo: $}), '}  (', (self register: srcR) hex, ') to ',  (self sp - 4) hex ].
					(self instructionIsPop: word) ifTrue: ["pop - " 
						^ (anInstructionString readStream upTo: $}), '}  (', (memory longAt: self sp) hex, ') ' , ' from ' , self sp hex ].

					"look for a ld/st of the sp"
					(self instructionIsLDRSP: word) ifTrue:[| val |
						val := operand > memory memory size
											ifTrue: [aSymbolManager simulatedVariableAt: operand ]
											ifFalse: [memory longAt: operand].
						^anInstructionString, '; Load SP (', (val ifNil:['unknown'] ifNotNil:[:v| v hex]) , ') from ', (addressinatorBlock value: operand)].
					(self instructionIsSTRSP: word) ifTrue:[
						^anInstructionString, '; Save SP (', self sp hex, ') to ',  (addressinatorBlock value: operand)].
					]
				ifFalse:
					["check for SP changers not relating to read/writing data"
					(self instructionIsAlignSP: word)
						ifTrue: [^anInstructionString, ' ALIGN SP ' , self sp hex; cr].
					(self instructionIsAddSP: word)
						ifTrue:[^anInstructionString, ' ADD ', (word bitAnd: 16rFF) asString,' to SP = ' , self sp hex].				

					"check for the end of a mov/orr/orr/orr set filling a reg with a const"
					opcode := word >> 21 bitAnd: 16rF.
					 opcode ~= CogARMCompiler orOpcode ifTrue:
						[^anInstructionString].
					 rotate := word >> 8 bitAnd: 16rF.
					 mode := word >> 25 bitAnd: 7.
					 "CogARMCompiler always uses a 0 rotate in the last operand of the final ORR when building long constants."
					 (mode = 1 and: [rotate ~= 0]) ifTrue:
						[^anInstructionString].
					 operand := aSymbolManager backEnd literalBeforeFollowingAddress: address + 4]].
	"is there an interesting address with this?"
	^anInstructionString", (addressinatorBlock value: operand) <-------------- NEEDS FIXING BETTERER"