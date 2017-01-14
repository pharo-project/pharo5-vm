tests
testCMPXCHGMwrR
	"self new testCMPXCHGMwrR"
	| cmpxchgMwrR lock |
	cmpxchgMwrR := CogIA32Compiler classPool at: #CMPXCHGMwrR.
	lock := CogIA32Compiler classPool at: #LOCK.
	CogIA32CompilerForTests registersWithNamesDo:
		[:sreg :srname|
		CogIA32CompilerForTests registersWithNamesDo:
			[:dreg :drname|
			((1 to: 19 by: 3) collect: [:po2| 2 raisedToInteger: po2]) do:
				[:offset|
				#(false true) do:
					[:prefixLock| | memory |
					self resetGen.
					prefixLock ifTrue: [self gen: lock].
					self gen: cmpxchgMwrR operand: offset operand: sreg operand: dreg.
					memory := self generateInstructions.
					self processor
						disassembleInstructionAt: 0
						In: memory
						into: [:str :sz| | plainJane herIntended |
							plainJane := self strip: str.
							herIntended := (prefixLock ifTrue: ['lock '] ifFalse: ['']),
											'cmpxchgl ', drname, ', 0x', (offset hex allButFirst: 3), '(', srname, ')'.
							self assert: herIntended equals: plainJane.
							self assert: memory size = sz]]]]]