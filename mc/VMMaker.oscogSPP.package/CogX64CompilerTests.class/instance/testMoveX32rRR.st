tests
testMoveX32rRR
	"self new testMoveX32rRR"
	self concreteCompilerClass registersWithNamesDo:
		[:idxreg :irname|
			irname ~= '%rsp' ifTrue:
				[self concreteCompilerClass registersWithNamesDo:
					[:basereg :brname|
					self concreteCompilerClass doubleWordRegistersWithNamesDo:
						[:dreg :drname| | inst len |
						inst := self gen: MoveX32rRR operand: idxreg operand: basereg operand: dreg.
						len := inst concretizeAt: 0.
						self processor
							disassembleInstructionAt: 3
							In: inst machineCode object
							into: [:str :sz| | plainJane herIntended |
								"Convert e.g. '00000000: movl %eax, 0x2(%eax) : 89 40 02' to  'movl %eax, 0x2(%eax)'"
								plainJane := self strip: str.
								herIntended := 'movl (', brname, ',', irname, ',4), ',drname.
								self assert: herIntended equals: plainJane.
								self assert: len - 3 = sz]]]]]