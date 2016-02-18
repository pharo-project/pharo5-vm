tests
testMoveM64rRd
	"self new testMoveM64rRd"
	CogIA32CompilerForTests registersWithNamesDo:
		[:sreg :srname|
		CogIA32CompilerForTests xmmRegistersWithNamesDo:
			[:dreg :drname|
			((1 to: 19 by: 3) collect: [:po2| 2 raisedToInteger: po2]) do:
				[:offset| | inst len |
				inst := self gen: MoveM64rRd operand: offset operand: sreg operand: dreg.
				len := inst concretizeAt: 0.
				self processor
					disassembleInstructionAt: 0
					In: inst machineCode object
					into: [:str :sz| | plainJane herIntended |
						plainJane := self strip: str.
						herIntended := 'movsd 0x', (offset hex allButFirst: 3), '(', srname, '), ', drname.
						self assert: herIntended equals: plainJane.
						self assert: len = sz]]]]