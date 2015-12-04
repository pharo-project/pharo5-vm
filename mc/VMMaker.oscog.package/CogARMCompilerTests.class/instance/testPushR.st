tests
testPushR
	"self new testPushR"
	
	self concreteCompilerClass registersWithNamesDo:
		[:r :name | | inst len |
		inst := self gen: PushR operand: r.
		len := inst concretizeAt: 0.
		self
			disassembleInstructionAt: 0
			In: inst
			into: [:str :sz| | plainJane herIntended |
				"Convert e.g. '00000000: movl %eax, 0x2(%eax) : 89 40 02' to  'movl %eax, 0x2(%eax)'"
				plainJane := self strip: str.
				herIntended := 'push	{', name ,'}'.
				self assert: herIntended equals: plainJane.
				self assert: len = 4]].
