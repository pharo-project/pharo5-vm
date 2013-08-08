accessing
stackPointers
	"Collect the stack depth for each bytecode in the method.
	 For the convenience of clients, write teh stack depth for extended bytecodes
	 to the bytecode pc, as well as the bytecocdes' extensions' pcs."
	| stackPointers end |
	stackPointers :=  Array new: (end := self method endPC).
	[pc <= end] whileTrue:
		[stackPointers at: pc put: stackp.
		 self method usesAlternateBytecodeSet ifTrue:
			[self extensionsAt: pc into:
				[:extA :extB :delta|
				delta > 0 ifTrue:
					[stackPointers at: pc + delta put: stackp]]].
		 self interpretNextInstructionFor: self].
	^stackPointers