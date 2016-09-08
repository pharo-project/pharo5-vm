tests
testMoveXwrRR
	"self new testMoveXwrRR"
	self concreteCompilerClass registersWithNamesDo:
		[:idxreg :irname|
			irname ~= '%rsp' ifTrue:
				[self concreteCompilerClass registersWithNamesDo:
					[:basereg :brname|
					self concreteCompilerClass registersWithNamesDo:
						[:dreg :drname| | inst len |
						inst := self gen: MoveXwrRR operand: idxreg operand: basereg operand: dreg.
						len := inst concretizeAt: 0.
						self processor
							disassembleInstructionAt: 0
							In: inst machineCode object
							into: [:str :sz| | plainJane herIntended |
								"Convert e.g. '00000000: movl %eax, 0x2(%eax) : 89 40 02' to  'movl %eax, 0x2(%eax)'"
								plainJane := self strip: str.
								herIntended := 'movq (', brname, ',', irname, ',8), ',drname.
								self assert: herIntended equals: plainJane.
								self assert: len = sz]]]]]