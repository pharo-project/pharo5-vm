tests
testMoveMbrR
	"self new testMoveMbrR"
	CogIA32CompilerForTests registersWithNamesDo:
		[:sreg :srname|
		CogIA32CompilerForTests registersWithNamesDo:
			[:dreg :drname| | brname |
			dreg < 4 ifTrue:
				[brname := #('%al' '%cl' '%dl' '%bl') at: dreg + 1.
				((1 to: 19 by: 3) collect: [:po2| 2 raisedToInteger: po2]) do:
					[:offset| | inst len |
					inst := self gen: MoveMbrR operand: offset operand: sreg operand: dreg.
					len := inst concretizeAt: 0.
					self processor
						disassembleInstructionAt: 0
						In: inst machineCode object
						into: [:str :sz| | plainJane herIntended |
							plainJane := self strip: str.
							herIntended := 'movb 0x', (offset hex allButFirst: 3), '(', srname, '), ', brname.
							self assert: (plainJane match: herIntended).
							self assert: len = sz]]]]]