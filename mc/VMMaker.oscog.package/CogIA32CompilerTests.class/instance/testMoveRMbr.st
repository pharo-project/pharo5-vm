tests
testMoveRMbr
	"self new testMoveRMbr"
	CogIA32CompilerForTests registersWithNamesDo:
		[:sreg :srname| | brname |
		sreg < 4 ifTrue:
			[brname := #('%al' '%cl' '%dl' '%bl') at: sreg + 1.
			CogIA32CompilerForTests registersWithNamesDo:
				[:dreg :drname|
				((1 to: 19 by: 3) collect: [:po2| 2 raisedToInteger: po2]) do:
					[:offset| | inst len |
					inst := self gen: MoveRMbr operand: sreg operand: offset operand: dreg.
					len := inst concretizeAt: 0.
					self processor
						disassembleInstructionAt: 0
						In: inst machineCode object
						into: [:str :sz| | plainJane herIntended |
							plainJane := self strip: str.
							herIntended := 'movb ', brname, ', 0x', (offset hex allButFirst: 3), '(', drname, ')'.
							self assert: (plainJane match: herIntended).
							self assert: len = sz]]]]]