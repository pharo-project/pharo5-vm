tests
testMoveM64rRd
	"self new testMoveM64rRd"
	self concreteCompilerClass registersWithNamesDo:
		[:sreg :srname|
		self concreteCompilerClass xmmRegistersWithNamesDo:
			[:dreg :drname|
			#(0 8 32760) do:
				[:offset| | inst len |
				inst := self gen: MoveM64rRd operand: offset operand: sreg operand: dreg.
				len := inst concretizeAt: 0.
				self processor
					disassembleInstructionAt: 0
					In: inst machineCode object
					into: [:str :sz| | plainJane herIntended |
						plainJane := self strip: str.
						herIntended := 'movq ',
										(offset = 0
											ifTrue: ['']
											ifFalse: ['0x', ((offset printStringBase: 16 length: 16 padded: true) asLowercase)]),
										'(', srname, '), ', drname.
						self assert: herIntended equals: plainJane.
						self assert: len = sz]]]]