tests
testTstCqR
	"self new testTstCqR"
	self concreteCompilerClass registersWithNamesDo:
		[:reg :theRegname|
		#(16r1 16r3 16r7 16r555555 16rAAAAAA) do:
			[:const| | op regname inst len constString|
			inst := self gen: TstCqR operand: const operand: reg.
			len := inst concretizeAt: 0.
			(inst isQuick: const)
				ifTrue:
					[op := 'testb'.
					 regname := reg < 8
									ifTrue: [#('%al' '%cl' '%dl' '%bl' '%spl' '%bpl' '%sil' '%dil') at: reg + 1]
									ifFalse: [theRegname, 'b'].
					 constString := const printStringBase: 16 length: 2 padded: true]
				ifFalse:
					[op := 'testq'.
					 regname := theRegname.
					 constString := const printStringBase: 16 length: 16 padded: true].
			self processor
				disassembleInstructionAt: 0
				In: inst machineCode object
				into: [:str :sz| | plainJane herIntended |
					"Convert e.g. '00000000: movl %eax, 0x2(%eax) : 89 40 02' to  'movl %eax, 0x2(%eax)'"
					plainJane := self strip: str.
					herIntended := op, ' $0x', constString, ', ', regname.
					self assert: herIntended equals: plainJane.
					self assert: len = sz]]]