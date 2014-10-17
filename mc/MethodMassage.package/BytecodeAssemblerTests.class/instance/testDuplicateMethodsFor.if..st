test support
testDuplicateMethodsFor: aBehavior if: methodSelectBlock
	aBehavior selectors asArray sort do:
		[:sel| | method disassembly assembly |
		method := aBehavior compiledMethodAt: sel.
		(methodSelectBlock value: method) ifTrue:
			[disassembly := BytecodeDisassembler new disassemble: method.
			 assembly := BytecodeAssembler new assemble: disassembly.
			"method indexOfDifferenceWith: assembly"
			 self assert: method equals: assembly]]