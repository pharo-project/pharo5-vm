tests
testAdd
	"self new testAdd"
	
	"the forms are valid, "
	"test AddCqR"
	self concreteCompilerClass registersWithNamesDo: [ :reg :regName |
		#(0 16rF 16rFF) do:
			[:n| | inst len |
			inst := self gen: AddCqR operand: n operand: reg.
			len := inst concretizeAt: 0.
			self processor
				disassembleInstructionAt: 0
				In: inst machineCode object
				into: [:str :sz| | plainJane herIntended |
					plainJane := self strip: str.
					herIntended := 'adds	', regName, ', ', regName, ', #', n asString.
					self assert: (plainJane match: herIntended)]]].
		
	"test AddCwR"
	self concreteCompilerClass registersWithNamesDo: [ :reg :regName |
		#(16rFFFFFFFF 16r88888888 0) do:
			[:n| | inst len |
			inst := self gen: AddCwR operand: n operand: reg.
			len := inst concretizeAt: 0.
			self processor
				disassembleInstructionAt: 0
				In: inst machineCode object
				into: [:str :sz| | plainJane herIntended |
					plainJane := self strip: str.
					herIntended := 'mov	sl, #', (n bitAnd: 16rFF << 8) asString.
					self assert: (plainJane match: herIntended)].
			self processor
				disassembleInstructionAt: 4
				In: inst machineCode object
				into: [:str :sz| | plainJane herIntended |
					plainJane := self strip: str.
					herIntended := 'orr	sl, sl, #', (n bitAnd: 16rFF << 16) asString.
					self assert: (plainJane match: herIntended)].
			self processor
				disassembleInstructionAt: 8
				In: inst machineCode object
				into: [:str :sz| | plainJane herIntended |
					plainJane := self strip: str.
					herIntended := 'orr	sl, sl, #', (n bitAnd: 16rFF << 24) signedIntFromLong asString.
					self assert: (plainJane match: herIntended)].
			self processor
				disassembleInstructionAt: 12
				In: inst machineCode object
				into: [:str :sz| | plainJane herIntended |
					plainJane := self strip: str.
					herIntended := 'orr	sl, sl, #', (n bitAnd: 16rFF) asString.
					self assert: (plainJane match: herIntended)].
			self processor
				disassembleInstructionAt: 16
				In: inst machineCode object
				into: [:str :sz| | plainJane herIntended |
					plainJane := self strip: str.
					herIntended := 'adds	', regName, ', ', regName, ', sl'.
					self assert: (plainJane match: herIntended)]]]
