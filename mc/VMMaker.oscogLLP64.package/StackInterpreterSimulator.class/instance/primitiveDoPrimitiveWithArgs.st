debugging traps
primitiveDoPrimitiveWithArgs
	NewspeakVM ifFalse: [self halt].
	^super primitiveDoPrimitiveWithArgs