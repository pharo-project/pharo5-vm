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
						"Convert e.g. '00000000: movq %rax, 0x2(%rax) : 48 89 40 02' to  'movl %rax, 0x2(%rax)'"
						plainJane := self strip: str.
						po := offset bitAnd: 1 << self processor bitsInWord - 1.
						herIntended := 'movq ', srname, ', ', (offset = 0 ifTrue: [''] ifFalse: ['0x', (po printStringBase: 16 length: 16 padded: true)]), '(',drname,')'.
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
						herIntended := 'movq ', srname, ', ', (offset = 0 ifTrue: [''] ifFalse: ['0x', (po printStringBase: 16 length: 16 padded: true)]), '(',drname,')'.
						((plainJane match: herIntended) and: [len = sz]) ifFalse:
							[failures at: herIntended put: plainJane]]]]].
	 failures"