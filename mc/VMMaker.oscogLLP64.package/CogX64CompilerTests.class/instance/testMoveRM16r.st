tests
testMoveRM16r
	"self new testMoveRM16r"
	self concreteCompilerClass wordRegistersWithNamesDo:
		[:sreg :srname|
		self concreteCompilerClass registersWithNamesDo:
			[:dreg :drname|
			((1 to: 19 by: 3) collect: [:po2| 2 raisedToInteger: po2]) do:
				[:offset| | inst len |
				inst := self gen: MoveRM16r operand: sreg operand: offset operand: dreg.
				len := inst concretizeAt: 0.
				self processor
					disassembleInstructionAt: 0
					In: inst machineCode object
					into: [:str :sz| | plainJane herIntended po |
						plainJane := self strip: str.
						po := offset bitAnd: 1 << self processor bitsInWord - 1.
						herIntended := 'movw ', srname, (offset = 0 ifTrue: [', '] ifFalse: [', 0x', (po printStringBase: 16 length: 16 padded: true)]), '(', drname, ')'.
						self assert: herIntended equals: plainJane.
						self assert: len = sz]]]]