tests
testMoveXbrRR
	"self new testMoveXbrRR"
	CogIA32CompilerForTests registersWithNamesDo:
		[:idxreg :irname|
		irname ~= '%esp' ifTrue:
			[CogIA32CompilerForTests registersWithNamesDo:
				[:basereg :brname|
				CogIA32CompilerForTests registersWithNamesDo:
					[:dreg :drname| | inst len |
					inst := self gen: MoveXbrRR operand: idxreg operand: basereg operand: dreg.
					len := inst concretizeAt: 0.
					self processor
						disassembleInstructionAt: 0
						In: inst machineCode object
						into: [:str :sz| | plainJane herIntended |
							"Convert e.g. '00000000: movzbl %ds:(%eax,%eax,1), %eax : 0F B6 04 00 ' to  'movzbl (%eax,%eax,1)'"
							plainJane := self strip: str.
							herIntended := 'movzbl (', brname, ',', irname, ',1), ',drname.
							self assert: herIntended equals: plainJane.
							self assert: len = sz]]]]]