tests
testLogicalShiftRightCqR
	"CogIA32CompilerTests new testLogicalShiftRightCqR"
	self concreteCompilerClass registersWithNamesDo:
		[:reg :regname|
		1 to: 31 do:
			[:shift| | inst len |
			inst := self gen: LogicalShiftRightCqR operand: shift operand: reg.
			len := inst concretizeAt: 0.
			self processor
				disassembleInstructionAt: 0
				In: inst machineCode object
				into: [:str :sz| | plainJane herIntended |
					"Convert e.g. '00000000: movl %eax, 0x2(%eax) : 89 40 02' to  'movl %eax, 0x2(%eax)'"
					plainJane := self strip: str.
					herIntended := 'shrl $', (shift > 1
												ifTrue: ['0x', (shift printStringBase: 16 length: 2 padded: true)]
												ifFalse: [shift asInteger]), ', ', regname.
					self assert: herIntended equals: plainJane.
					self assert: len = sz]]]