tests
testMoveRX32rR
	"self new testMoveRX32rR"
	self concreteCompilerClass registersWithNamesDo:
		[:idxreg :irname|
			irname ~= '%rsp' ifTrue:
				[self concreteCompilerClass registersWithNamesDo:
					[:basereg :brname|
					self concreteCompilerClass doubleWordRegistersWithNamesDo:
						[:sreg :srname| | inst len |
						inst := self gen: MoveRX32rR operand: sreg operand: idxreg operand: basereg.
						len := inst concretizeAt: 0.
						self processor
							disassembleInstructionAt: 0
							In: inst machineCode object
							into: [:str :sz| | plainJane herIntended |
								"Convert e.g. '00000000: movl %rax, 0x2(%rax) : 89 40 02' to  'movl %rax, 0x2(%rax)'"
								plainJane := self strip: str.
								herIntended := 'movl ', srname, ', (', brname, ',', irname, ',4)'.
								self assert: herIntended equals: plainJane.
								self assert: len = sz]]]]]