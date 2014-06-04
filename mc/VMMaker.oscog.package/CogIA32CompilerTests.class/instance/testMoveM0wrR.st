tests
testMoveM0wrR
	"self new testMoveM0wrR"
	CogIA32CompilerForTests registersWithNamesDo:
		[:sreg :srname|
		CogIA32CompilerForTests registersWithNamesDo:
			[:dreg :drname| | inst len |
			inst := self gen: MoveMwrR operand: 0 operand: sreg operand: dreg.
			len := inst concretizeAt: 0.
			self processor
				disassembleInstructionAt: 0
				In: inst machineCode object
				into: [:str :sz| | plainJane herIntended |
					plainJane := self strip: str.
					herIntended := 'movl (', srname, '), ', drname.
					self assert: (plainJane match: herIntended).
					self assert: len = sz]]]