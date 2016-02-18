tests
testMoveRRd
	"self new testMoveRRd"
	self concreteCompilerClass registersWithNamesDo:
		[:sreg :srname|
		self concreteCompilerClass xmmRegistersWithNamesDo:
			[:dreg :drname| | inst len |
			inst := self gen: MoveRRd operand: sreg operand: dreg.
			len := inst concretizeAt: 0.
			self processor
				disassembleInstructionAt: 0
				In: inst machineCode object
				into: [:str :sz| | plainJane herIntended |
					plainJane := self strip: str.
					herIntended := 'movq ', srname, ', ', drname.
					"N.B. bochs 2.3.7 gets many cases wrong, e.g.
						movq %ds:(%rax), %xmm8 : F3 44 0F 7E 00
					 is disassembled as
						rep movq %ds:(%rax), %xmm8 : F3 44 0F 7E 00"
					(plainJane beginsWith: 'rep ') ifTrue:
						[plainJane := plainJane allButFirst: 4].
					self assert: herIntended equals: plainJane.
					self assert: len = sz]]]

"| them it |
them := OrderedCollection new.
[(it := CogX64CompilerTests new) testMoveRRd]
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
[(it := CogX64CompilerTests new) testMoveRRd]
	on: TestResult failure
	do: [:ex| | ctxt |
		ctxt := ex signalerContext findContextSuchThat: [:c| c selector == #assert:equals:]..
		them addLast: {ctxt tempAt: 1. ctxt tempAt: 2}.
		ResumableTestFailure adoptInstance: ex.
		ex resume].
them size"