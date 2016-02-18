tests
testMoveRMwr
	"self new testMoveRMwr"
	self concreteCompilerClass registersWithNamesDo:
		[:sreg :srname|
		self concreteCompilerClass registersWithNamesDo:
			[:dreg :drname| | inst len |
			#(0 64 65536 -64 -65536) do:
				[:offset|
				inst := self gen: MoveRMwr operand: sreg operand: offset operand: dreg.
				len := inst concretizeAt: 0.
				self processor
					disassembleInstructionAt: 0
					In: inst machineCode object
					into: [:str :sz| | plainJane herIntended po |
						"Convert e.g. '00000000: movl %eax, 0x2(%eax) : 89 40 02' to  'movl %eax, 0x2(%eax)'"
						plainJane := self strip: str.
						po := offset bitAnd: 1 << self processor bitsInWord - 1.
						herIntended := 'movl ', srname, ', ', (offset = 0 ifTrue: [''] ifFalse: ['0x', (po printStringBase: 16)]), '(',drname,')'.
						self assert: herIntended equals: plainJane.
						self assert: len = sz]]]]

	"| failures |
	 failures := Dictionary new.
	 self concreteCompilerClass registersWithNamesDo:
		[:sreg :srname|
		self concreteCompilerClass registersWithNamesDo:
			[:dreg :drname| | inst len |
			#(0 64 65536 -64 -65536) do:
				[:offset|
				inst := self gen: MoveRMwr operand: sreg operand: offset operand: dreg.
				len := inst concretizeAt: 0.
				self processor
					disassembleInstructionAt: 0
					In: inst machineCode object
					into: [:str :sz| | plainJane herIntended po |
						plainJane := self strip: str.
						po := offset bitAnd: 1 << self processor bitsInWord - 1.
						herIntended := 'movl ', srname, ', ', (offset = 0 ifTrue: [''] ifFalse: ['0x', (po printStringBase: 16)]), '(',drname,')'.
						((plainJane match: herIntended) and: [len = sz]) ifFalse:
							[failures at: herIntended put: plainJane]]]]].
	 failures"