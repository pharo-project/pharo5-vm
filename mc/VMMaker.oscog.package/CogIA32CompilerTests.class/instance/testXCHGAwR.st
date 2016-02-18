tests
testXCHGAwR
	"self new testXCHGAwR"
	| xchgAwR |
	xchgAwR := CogIA32Compiler classPool at: #XCHGAwR.
	CogIA32CompilerForTests registersWithNamesDo:
		[:reg :regname|
		#(16r555555 16rAAAAAA) do:
			[:addr| | inst len |
			inst := self gen: xchgAwR operand: addr operand: reg.
			len := inst concretizeAt: 0.
			self processor
				disassembleInstructionAt: 0
				In: inst machineCode object
				into: [:str :sz| | plainJane herIntended |
					"Convert e.g. '00000000: movl %eax, 0x2(%eax) : 89 40 02' to  'movl %eax, 0x2(%eax)'"
					plainJane := self strip: str.
					herIntended := 'xchgl ', regname, ', 0x', (addr hex allButFirst: 3).
					self assert: herIntended equals: plainJane.
					self assert: len = sz]]]