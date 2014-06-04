accessing
stackPointers
	"Collect the stack depth for each bytecode in the method.
	 For the convenience of clients, write the stack depth for extended bytecodes
	 to the bytecode pc, as well as the bytecocdes' extensions' pcs."
	| method encoderClass stackPointers end |
	stackPointers :=  Array new: (end := (method := self method) endPC).
	encoderClass := method encoderClass.
	[pc <= end] whileTrue:
		[stackPointers at: pc put: stackp.
		 encoderClass extensionsAt: pc in: method into:
			[:extA :extB :delta|
			delta > 0 ifTrue:
				[stackPointers at: pc + delta put: stackp]].
		 self interpretNextInstructionFor: self].
	^stackPointers