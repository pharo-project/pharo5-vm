tests
testSubCqR
	"self new testSubCqR"
	self concreteCompilerClass registersWithNamesDo:
		[:reg :regname|
		#(16r1 16r3 16r7 16r555555 16rAAAAAA) do:
			[:const| | inst len|
			inst := self gen: SubCqR operand: const operand: reg.
			len := inst concretizeAt: 0.
			self processor
				disassembleInstructionAt: 0
				In: inst machineCode object
				into: [:str :sz| | plainJane herIntended |
					"Convert e.g. '00000000: movl %eax, 0x2(%eax) : 89 40 02' to  'movl %eax, 0x2(%eax)'"
					plainJane := self strip: str.
					herIntended := 'subq $0x', (const printStringBase: 16 length: 16 padded: true), ', ', regname.
					self assert: herIntended equals: plainJane.
					self assert: len = sz]]]