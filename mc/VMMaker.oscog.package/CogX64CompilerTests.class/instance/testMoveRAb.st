tests
testMoveRAb
	"self new testMoveRAb"
	self concreteCompilerClass byteRegistersWithNamesDo:
		[:reg :regname| | reg64name |
		reg64name := self processor registerStateGetters at: reg + 1.
		#(16r555555 16rAAAAAA 16r5A5A5A5A5A5A) do:
			[:addr| | inst len totalsz |
			inst := self gen: MoveRAb operand: reg operand: addr.
			len := inst concretizeAt: 0.
			totalsz := 0.
			regname ~= '%al' ifTrue:
				[self processor
					disassembleInstructionAt: 0
					In: inst machineCode object
					into: [:str :sz| | plainJane herIntended |
						plainJane := self strip: str.
						herIntended := 'xchgq %rax, %', reg64name.
						self assert: herIntended equals: plainJane.
						totalsz := sz]].
			self processor
				disassembleInstructionAt: totalsz
				In: inst machineCode object
				into: [:str :sz| | plainJane herIntended |
					plainJane := self strip: str.
					herIntended := 'movb %al, 0x', (addr printStringBase: 16 length: 16 padded: true).
					self assert: herIntended equals: plainJane.
					totalsz := totalsz + sz].
			regname ~= '%al' ifTrue:
				[self processor
					disassembleInstructionAt: totalsz
					In: inst machineCode object
					into: [:str :sz| | plainJane herIntended |
						plainJane := self strip: str.
						herIntended := 'xchgq %rax, %', reg64name.
						self assert: herIntended equals: plainJane.
						totalsz := totalsz + sz]].
			self assert: len = totalsz]]