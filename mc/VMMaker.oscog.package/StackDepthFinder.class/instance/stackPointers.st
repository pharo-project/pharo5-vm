accessing
stackPointers
	"Collect the stack depth for each bytecode in the method.
	 For the convenience of clients, write the stack depth for extended bytecodes
	 to the bytecode pc, as well as the bytecocdes' extensions' pcs."
	| method stackPointers end |
	"endPC +1 because of full blocks that can end with NLR effectively mapping the pc right after the end PC"
	stackPointers :=  Array new: (end := (method := self method) endPC) + 1.
	encoderClass ifNil: [encoderClass := method encoderClass].
	[pc <= end] whileTrue:
		[stackPointers at: pc put: stackp.
		 encoderClass extensionsAt: pc in: method into:
			[:extA :extB :delta|
			2 to: delta by: 2 do: [ :dlt |
				stackPointers at: pc + dlt put: stackp]].
		 self interpretNextInstructionFor: self].
	^stackPointers