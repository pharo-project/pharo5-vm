tests
testAndCqR
	"self new testAndCqR"
	self concreteCompilerClass registersWithNamesDo:
		[:reg :regname|
		#(16r1 16r3 16r7 16r555555 16rAAAAAA "16r55AA55AA55AA 16rAA55AA55AA55 no 64-bit constant support with AndC") do:
			[:const| | inst len|
			inst := self gen: AndCqR operand: const operand: reg.
			len := inst concretizeAt: 0.
			self processor
				disassembleInstructionAt: 0
				In: inst machineCode object
				into: [:str :sz| | plainJane herIntended |
					"Convert e.g. '00000000: movq %rax, 0x2(%rax) : 89 40 02' to  'movl %rax, 0x2(%rax)'"
					plainJane := self strip: str.
					herIntended := 'andq $0x', (const printStringBase: 16 length: 16 padded: true), ', ', regname.
					self assert: (plainJane match: herIntended).
					self assert: len = sz]]]