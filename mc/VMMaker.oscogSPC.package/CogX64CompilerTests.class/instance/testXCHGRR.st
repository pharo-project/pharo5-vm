tests
testXCHGRR
	"CogX64CompilerTests new testXCHGRR"
	| xchgrr |
	xchgrr := (self concreteCompilerClass bindingOf: #XCHGRR) value.
	self concreteCompilerClass registersWithNamesDo:
		[:sreg :sregname|
		self concreteCompilerClass registersWithNamesDo:
			[:dreg :dregname| | inst len |
			inst := self gen: xchgrr operand: sreg operand: dreg.
			len := inst concretizeAt: 0.
			self processor
				disassembleInstructionAt: 0
				In: inst machineCode object
				into: [:str :sz| | plainJane herIntended |
					"Convert e.g. '00000000: movl %eax, 0x2(%eax) : 89 40 02' to  'movl %eax, 0x2(%eax)'"
					plainJane := self strip: str.
					herIntended := dreg = 0
										ifTrue: [sreg = 0 ifTrue: ['nop '] ifFalse: ['xchgq ', dregname, ', ', sregname]]
										ifFalse: ['xchgq ', sregname, ', ', dregname].
					self assert: herIntended equals: plainJane.
					self assert: len = sz]]]