tests
testMoveRXwrR
	"self new testMoveRXwrR"
	self concreteCompilerClass registersWithNamesDo:
		[:idxreg :irname|
		irname ~= '%esp' ifTrue:
			[self concreteCompilerClass registersWithNamesDo:
				[:basereg :brname|
				self concreteCompilerClass registersWithNamesDo:
					[:sreg :srname| | inst len |
					inst := self gen: MoveRXwrR operand: sreg operand: idxreg operand: basereg.
					len := inst concretizeAt: 0.
					self processor
						disassembleInstructionAt: 0
						In: inst machineCode object
						into: [:str :sz| | plainJane herIntended |
							plainJane := self strip: str.
							herIntended := 'movl ', srname, ', (', brname, ',', irname, ',4)'.
							self assert: herIntended equals: plainJane.
							self assert: len = sz]]]]]