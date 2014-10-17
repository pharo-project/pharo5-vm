test support
testAsAssemblerFor: aMethod
	"self new testAsAssemblerFor: self >> #testAsAssemblerFor:"
	| assemblerMethod assembler reassembledMethod |
	assemblerMethod := BytecodeDisassembler new disassemble: aMethod.
	assembler := String streamContents: [:s| assemblerMethod printAsAssemblerOn: s].
	self shouldnt: [reassembledMethod := Compiler evaluate: assembler]
		raise: Error.
	self assert: assemblerMethod compiledMethodClass equals: reassembledMethod compiledMethodClass.
	self assert: assemblerMethod flag equals: reassembledMethod flag.
	self assert: assemblerMethod frameSize equals: reassembledMethod frameSize.
	self assert: assemblerMethod methodClass equals: reassembledMethod methodClass.
	self assert: assemblerMethod numArgs equals: reassembledMethod numArgs.
	self assert: assemblerMethod numTemps equals: reassembledMethod numTemps.
	self assert: assemblerMethod primitive equals: reassembledMethod primitive.
	self assert: assemblerMethod selector equals: reassembledMethod selector.
	self assert: assemblerMethod signFlag equals: reassembledMethod signFlag.
	1 to: reassembledMethod literals size do:
		[:i|
		self assert: (assemblerMethod literals at: i)
			equals: (reassembledMethod literals at: i)].
	assemblerMethod instructions
		ifNil: [self assert: reassembledMethod instructions isNil]
		ifNotNil:
			[:insts|
			 self assert: insts size equals: reassembledMethod instructions size.
			 "Nil the labels' values for analogousCodeTo: comparison below; the values
			  are usefully the bytecode pcs of the labels, but this fails the comparisons."
			 insts do: [:inst| inst isVariableBinding ifTrue: [inst value: nil]].
			 insts
				with: reassembledMethod instructions
				do: [:old :new|
					old isVariableBinding
						ifTrue: [self assert: old key = new key]
						ifFalse: [self assert: (old analogousCodeTo: new)]]].
	self assert: aMethod equals: (BytecodeAssembler new assemble: reassembledMethod)