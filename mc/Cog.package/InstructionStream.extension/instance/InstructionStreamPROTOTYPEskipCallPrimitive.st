*Cog-method prototypes
InstructionStreamPROTOTYPEskipCallPrimitive
	"If the receiver's method starts with a callPrimitive: bytecode, skip it."
	| method encoderClass callPrimitiveCode |
	method := self method.
	encoderClass := method encoderClass.
	callPrimitiveCode := encoderClass callPrimitiveCode.
	(method byteAt: pc) = callPrimitiveCode ifTrue:
		[pc := pc + (encoderClass bytecodeSize: callPrimitiveCode)]