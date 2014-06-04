initialization
checkPrimitiveTableEnablers
	"Disable primitive generators with enablers that answer false."
	| primitiveDescriptor |
	<var: #primitiveDescriptor type: #'PrimitiveDescriptor *'>
	1 to: MaxCompiledPrimitiveIndex do:
		[:i|
		primitiveDescriptor := self addressOf: (primitiveGeneratorTable at: i).
		primitiveDescriptor enabled notNil ifTrue:
			[(self perform: primitiveDescriptor enabled with: i) ifFalse:
				[primitiveDescriptor primitiveGenerator: nil]]]