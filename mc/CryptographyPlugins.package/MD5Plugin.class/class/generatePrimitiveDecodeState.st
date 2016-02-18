code generation
generatePrimitiveDecodeState

	^'primitiveDecodeState: state
	"This method is generated. See #compileMethods on the class side."

	self primitive: ''primitiveDecodeState'' parameters: #(ByteArray).
	{1}' format: {
		self isPlatformBigEndian
			ifTrue: [ 'self decode: state sizeInIntegers: 4' ]
			ifFalse: [ '' ] }