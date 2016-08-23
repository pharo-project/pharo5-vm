tests
testRetN
	"self new testRetN"
	
	#(0) do:
		[:n| | inst len |
		inst := self gen: RetN operand: n.
		len := inst concretizeAt: 0.
		self
			disassembleInstructionAt: 0
			In: inst
			into: [:str :sz| | plainJane  |
				"Convert e.g. '00000000: movl %eax, 0x2(%eax) : 89 40 02' to  'movl %eax, 0x2(%eax)'"
				plainJane := self strip: str.
				self assert: (plainJane match: 'mov	pc, lr').
				self assert: len = sz]].
	
	#(1 2 3 4 5 6 7) do:
		[:n| | inst len |
		inst := self gen: RetN operand: n * 4.
		len := inst concretizeAt: 0.
		self
			disassembleInstructionAt: 0
			In: inst
			into: [:str :sz| | plainJane herIntended |
				plainJane := self strip: str.
				herIntended := 'add	sp, sp, #', (n * 4 )asString.
				self assert: herIntended equals: plainJane].
		self
			disassembleInstructionAt: 4
			In: inst
			into: [:str :sz| | plainJane |
				plainJane := self strip: str.
				self assert: (plainJane match: 'mov	pc, lr').		
		self assert: len = 8]]