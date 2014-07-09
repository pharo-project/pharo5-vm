disassembly
label
	"Override to add a label for the first bytecode pc.
	 Be careful to skip any initial callPrimitive bytecode."
	method isQuick ifFalse:
		[| startPC primCode|
		 startPC := (method primitive ~= 0
					 and: [(primCode := method encoderClass callPrimitiveCode) notNil])
						ifTrue: [method initialPC + ((InstructionStream on: method) bytecodeSize: primCode)]
						ifFalse: [method initialPC].
		 labels at: startPC put: true].
	super label