tests
testMoveXbrRR
	"self new testMoveXbrRR"
	self concreteCompilerClass registersWithNamesDo:
		[:idxreg :irname|
		irname ~= '%rsp' ifTrue:
			[self concreteCompilerClass registersWithNamesDo:
				[:basereg :brname|
				self concreteCompilerClass byteRegistersWithNamesDo:
					[:dreg :drname|
					((1 to: 19 by: 3) collect: [:po2| 2 raisedToInteger: po2]) do:
						[:offset| | inst len |
						inst := self gen: MoveXbrRR operand: idxreg operand: basereg operand: dreg.
						self deny: inst byteReadsZeroExtend.
						len := inst concretizeAt: 0.
						self processor
							disassembleInstructionAt: 0
							In: inst machineCode object
							into: [:str :sz| | plainJane herIntended |
								"Convert e.g. '00000000: movzbq %ds:(%rax,%rax,1), %rax : 48 0F B6 04 00 ' to  'movzbq (%rax,%rax,1), %rax'"
								plainJane := self strip: str.
								herIntended := 'movb (', brname, ',', irname, ',1), ',drname.
								self assert: (plainJane match: herIntended).
								self assert: len = sz]]]]]]