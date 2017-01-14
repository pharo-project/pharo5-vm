instruction decoding
callPrimitive: primitiveIndex
	"Call Primitive bytecode."
	"Phhh.... stackDeltaForPrimitive:in: is in BytecodeSets.  But since the default response
	 to callPrimitive: is nothing, just handle this with an MNU for now."
	[self drop: (encoderClass stackDeltaForPrimitive: primitiveIndex in: self method) negated]
		on: MessageNotUnderstood
		do: [:ex|
			ex message selector ~~ #stackDeltaForPrimitive:in: ifTrue:
				[ex pass]]