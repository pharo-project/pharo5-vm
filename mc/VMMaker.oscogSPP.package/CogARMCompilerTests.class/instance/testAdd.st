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
			self
				disassembleInstructionAt: 0
				In: inst
				into: [:str :sz| | plainJane herIntended |
					plainJane := self strip: str.
					herIntended := 'adds	', regName, ', ', regName, ', #', n asString.
					self assert: herIntended equals: plainJane]]].
		
	"test AddCwR"
	self concreteCompilerClass registersWithNamesDo: [ :reg :regName |
		#(16rFFFFFFFF 16r88888888 0) do:
			[:n| | inst len |
			inst := self gen: AddCwR operand: n operand: reg.
			len := inst concretizeAt: 0.
			self
				disassembleInstructionAt: 0
				In: inst
				into: [:str :sz| | plainJane herIntended |
					plainJane := self strip: str.
					herIntended := 'mov	ip, #', (n bitAnd: 16rFF << 24) signedIntFromLong asString.
					self assert: herIntended equals: plainJane].
			self
				disassembleInstructionAt: 4
				In: inst
				into: [:str :sz| | plainJane herIntended |
					plainJane := self strip: str.
					herIntended := 'orr	ip, ip, #', (n bitAnd: 16rFF << 16) asString.
					self assert: herIntended equals: plainJane].
			self
				disassembleInstructionAt: 8
				In: inst
				into: [:str :sz| | plainJane herIntended |
					plainJane := self strip: str.
					herIntended := 'orr	ip, ip, #', (n bitAnd: 16rFF << 8) signedIntFromLong asString.
					self assert: herIntended equals: plainJane].
			self
				disassembleInstructionAt: 12
				In: inst
				into: [:str :sz| | plainJane herIntended |
					plainJane := self strip: str.
					herIntended := 'orr	ip, ip, #', (n bitAnd: 16rFF) asString.
					self assert: herIntended equals: plainJane].
			self
				disassembleInstructionAt: 16
				In: inst
				into: [:str :sz| | plainJane herIntended |
					plainJane := self strip: str.
					herIntended := 'adds	', regName, ', ', regName, ', ip'.
					self assert: herIntended equals: plainJane]]]
