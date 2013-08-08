tests
testMoveRM0wr
	"self new testMoveRM0wr"
	CogIA32CompilerForTests registersWithNamesDo:
		[:sreg :srname|
		CogIA32CompilerForTests registersWithNamesDo:
			[:dreg :drname| | inst len |
			inst := self gen: MoveRMwr operand: sreg operand: 0 operand: dreg.
			len := inst concretizeAt: 0.
			self processor
				disassembleInstructionAt: 0
				In: inst machineCode object
				into: [:str :sz| | plainJane herIntended |
					"Convert e.g. '00000000: movl %eax, 0x2(%eax) : 89 40 02' to  'movl %eax, 0x2(%eax)'"
					plainJane := self strip: str.
					herIntended := 'movl ', srname, ', (',drname,')'.
					self assert: (plainJane match: herIntended).
					self assert: len = sz]]]