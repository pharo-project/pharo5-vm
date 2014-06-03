tests
testPrefetchAw
	"self new testPrefetchAw"
	
	#(16rFF00FF00 16r00000012) do:
		[:n| | inst len |
		inst := self gen: PrefetchAw operand: n.
		len := inst concretizeAt: 0.
		self processor
			disassembleInstructionAt: 12
			In: inst machineCode object
			into: [:str :sz| | plainJane herIntended |
				"Convert e.g. '00000000: movl %eax, 0x2(%eax) : 89 40 02' to  'movl %eax, 0x2(%eax)'"
				plainJane := self strip: str.
				herIntended := 'pld	[sl', ((n bitAnd: 16rFF) = 0 ifTrue: [''] ifFalse: [', #', (n bitAnd: 16rFF) asString]) ,']'.
				self assert: (plainJane match: herIntended).
				self assert: len = 16]].
