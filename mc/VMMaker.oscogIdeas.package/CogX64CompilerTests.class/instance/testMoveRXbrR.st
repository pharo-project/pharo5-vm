tests
testMoveRXbrR
	"self new testMoveXbrRR"
	self concreteCompilerClass registersWithNamesDo:
		[:idxreg :irname|
		irname ~= '%rsp' ifTrue:
			[self concreteCompilerClass registersWithNamesDo:
				[:basereg :brname|
				self concreteCompilerClass byteRegistersWithNamesDo:
					[:sreg :srname| | inst len |
					inst := self gen: MoveRXbrR operand: sreg operand: idxreg operand: basereg.
					len := inst concretizeAt: 0.
					self processor
						disassembleInstructionAt: 0
						In: inst machineCode object
						into: [:str :sz| | plainJane herIntended |
							plainJane := self strip: str.
							herIntended := 'movb ', srname, ', (', brname, ',', irname, ',1)'.
							self assert: herIntended equals: plainJane.
							self assert: len = sz]]]]]