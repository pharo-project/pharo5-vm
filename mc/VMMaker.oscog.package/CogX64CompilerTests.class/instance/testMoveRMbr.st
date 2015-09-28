tests
testMoveRMbr
	"self new testMoveRMbr"
	self concreteCompilerClass registersWithNamesDo:
		[:sreg :srname| | brname |
		sreg < 4 ifTrue:
			[brname := #('%al' '%cl' '%dl' '%bl') at: sreg + 1.
			self concreteCompilerClass registersWithNamesDo:
				[:dreg :drname|
				((1 to: 19 by: 3) collect: [:po2| 2 raisedToInteger: po2]) do:
					[:offset| | inst len |
					inst := self gen: MoveRMbr operand: sreg operand: offset operand: dreg.
					len := inst concretizeAt: 0.
					self processor
						disassembleInstructionAt: 0
						In: inst machineCode object
						into: [:str :sz| | plainJane herIntended po |
							plainJane := self strip: str.
							po := offset bitAnd: 1 << self processor bitsInWord - 1.
							herIntended := 'movb ', brname, (offset = 0 ifTrue: [', '] ifFalse: [', 0x', (po printStringBase: 16 length: 16 padded: true)]), '(', drname, ')'.
							self assert: (plainJane match: herIntended).
							self assert: len = sz]]]]]