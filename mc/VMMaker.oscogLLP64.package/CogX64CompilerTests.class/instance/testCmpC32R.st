tests
testCmpC32R
	"self new testCmpC32R"
	self concreteCompilerClass doubleWordRegistersWithNamesDo:
		[:reg :regname|
		#(16r1 16r3 16r7 16r555555 16rAAAAAA) do:
			[:const| | inst len|
			inst := self gen: CmpC32R operand: const operand: reg.
			len := inst concretizeAt: 0.
			self processor
				disassembleInstructionAt: 0
				In: inst machineCode object
				into: [:str :sz| | plainJane herIntended |
					"Convert e.g. '00000000: movl %eax, 0x2(%eax) : 89 40 02' to  'movl %eax, 0x2(%eax)'"
					plainJane := self strip: str.
					herIntended := 'cmpl $0x', (const printStringBase: 16 length: 8 padded: true), ', ', regname.
					self assert: herIntended equals: plainJane.
					self assert: len = sz]]]