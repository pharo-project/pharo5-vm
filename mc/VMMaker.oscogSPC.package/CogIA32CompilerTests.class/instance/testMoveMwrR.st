tests
testMoveMwrR
	"self new testMoveMwrR"
	self concreteCompilerClass registersWithNamesDo:
		[:sreg :srname|
		self concreteCompilerClass registersWithNamesDo:
			[:dreg :drname| | inst len |
			#(0 64 65536 -64 -65536) do:
				[:offset|
				inst := self gen: MoveMwrR operand: offset operand: sreg operand: dreg.
				len := inst concretizeAt: 0.
				self processor
					disassembleInstructionAt: 0
					In: inst machineCode object
					into: [:str :sz| | plainJane herIntended po |
						plainJane := self strip: str.
						po := offset bitAnd: 1 << self processor bitsInWord - 1.
						herIntended := 'movl ', (offset = 0 ifTrue: [''] ifFalse: ['0x', (po printStringBase: 16)]), '(', srname, '), ', drname.
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
				inst := self gen: MoveMwrR operand: offset operand: sreg operand: dreg.
				len := inst concretizeAt: 0.
				self processor
					disassembleInstructionAt: 0
					In: inst machineCode object
					into: [:str :sz| | plainJane herIntended po |
						plainJane := self strip: str.
						po := offset bitAnd: 1 << self processor bitsInWord - 1.
						herIntended := 'movl ', (offset = 0 ifTrue: [''] ifFalse: ['0x', (po printStringBase: 16)]), '(', srname, '), ', drname.
						((plainJane match: herIntended) and: [len = sz]) ifFalse:
							[failures at: herIntended put: plainJane]]]]].
	 failures"