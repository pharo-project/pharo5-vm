tests
testXCHGMwrR
	"self new testXCHGMwrR"
	| xchgMwrR |
	xchgMwrR := CogIA32Compiler classPool at: #XCHGMwrR.
	CogIA32CompilerForTests registersWithNamesDo:
		[:sreg :srname|
		CogIA32CompilerForTests registersWithNamesDo:
			[:dreg :drname|
			((1 to: 19 by: 3) collect: [:po2| 2 raisedToInteger: po2]) do:
				[:offset| | memory |
				self resetGen.
				self gen: xchgMwrR operand: offset operand: sreg operand: dreg.
				memory := self generateInstructions.
				self processor
					disassembleInstructionAt: 0
					In: memory
					into: [:str :sz| | plainJane herIntended |
						plainJane := self strip: str.
						herIntended := 'xchgl ', drname, ', 0x', (offset hex allButFirst: 3), '(', srname, ')'.
						self assert: herIntended equals: plainJane.
						self assert: memory size = sz]]]]