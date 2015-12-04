tests
testMoveAwR
	"self new testMoveAwR"
	self concreteCompilerClass registersWithNamesDo:
		[:reg :regname|
		#(16r555555 16rAAAAAA 16r5A5A5A5A5A5A) do:
			[:addr| | inst len totalsz |
			inst := self gen: MoveAwR operand: addr operand: reg.
			len := inst concretizeAt: 0.
			totalsz := 0.
			regname ~= '%rax' ifTrue:
				[self processor
					disassembleInstructionAt: 0
					In: inst machineCode object
					into: [:str :sz| | plainJane herIntended |
						plainJane := self strip: str.
						herIntended := 'xchgq %rax, ', regname.
						self assert: herIntended equals: plainJane.
						totalsz := sz]].
			self processor
				disassembleInstructionAt: totalsz
				In: inst machineCode object
				into: [:str :sz| | plainJane herIntended |
					plainJane := self strip: str.
					herIntended := 'movq 0x', (addr printStringBase: 16 length: 16 padded: true), ', %rax'.
					self assert: herIntended equals: plainJane.
					totalsz := totalsz + sz].
			regname ~= '%rax' ifTrue:
				[self processor
					disassembleInstructionAt: totalsz
					In: inst machineCode object
					into: [:str :sz| | plainJane herIntended |
						plainJane := self strip: str.
						herIntended := 'xchgq %rax, ', regname.
						self assert: herIntended equals: plainJane.
						totalsz := totalsz + sz]].
			self assert: len = totalsz]]