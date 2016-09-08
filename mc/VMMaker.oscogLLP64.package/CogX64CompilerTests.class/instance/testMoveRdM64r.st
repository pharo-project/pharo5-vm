tests
testMoveRdM64r
	"self new testMoveRdM64r"
	self concreteCompilerClass xmmRegistersWithNamesDo:
		[:sreg :srname|
		self concreteCompilerClass registersWithNamesDo:
			[:dreg :drname|
			#(0 8 256 32760) do:
				[:offset| | inst len |
				inst := self gen: MoveRdM64r operand: sreg operand: offset operand: dreg.
				len := inst concretizeAt: 0.
				self processor
					disassembleInstructionAt: 0
					In: inst machineCode object
					into: [:str :sz| | plainJane herIntended |
						plainJane := self strip: str.
						herIntended := 'movq ', srname,
											(offset = 0
												ifTrue: [', ']
												ifFalse: [', 0x', ((offset printStringBase: 16 length: 16 padded: true))]),
											'(', drname, ')'.
						self assert: herIntended equals: plainJane.
						self assert: len = sz]]]]

"| them it |
them := OrderedCollection new.
[(it := CogX64CompilerTests new) testMoveRdM64r]
	on: AssertionFailure, TestResult failure
	do: [:ex| | inst |
		ex class == AssertionFailure
			ifTrue:
				[inst := ex signalerContext receiver.
				it processor
					disassembleInstructionAt: 0
					In: inst machineCode object
					into: [:str :sz| them addLast: (it strip: str)]]
			ifFalse:
				[ResumableTestFailure adoptInstance: ex].
		ex resume].
them size"
"| them it |
them := OrderedCollection new.
[(it := CogX64CompilerTests new) testMoveRdM64r]
	on: TestResult failure
	do: [:ex| | ctxt |
		ctxt := ex signalerContext findContextSuchThat: [:c| c selector == #assert:equals:]..
		them addLast: {ctxt tempAt: 1. ctxt tempAt: 2}.
		ResumableTestFailure adoptInstance: ex.
		ex resume].
them size"