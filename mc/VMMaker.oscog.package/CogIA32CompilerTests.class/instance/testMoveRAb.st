tests
testMoveRAb
	"self new testMoveRAb"
	CogIA32CompilerForTests byteRegistersWithNamesDo:
		[:reg :regname|
		#(16r555555 16rAAAAAA) do:
			[:addr| | inst len |
			inst := self gen: MoveRAb operand: reg operand: addr.
			len := inst concretizeAt: 0.
			self processor
				disassembleInstructionAt: 0
				In: inst machineCode object
				into: [:str :sz| | plainJane herIntended |
					plainJane := self strip: str.
					herIntended := 'movb ', regname, ', 0x', (addr hex allButFirst: 3).
					self assert: herIntended equals: plainJane.
					self assert: len = sz]]]