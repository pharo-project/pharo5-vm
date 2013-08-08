primitives
primitiveForceJIT

	<export: true >
	
	| val result |
	
	val := self stackTop.
	
	(self isIntegerObject: val) ifTrue: [ ^ self primitiveFail ].	
	(self isCompiledMethod: val) ifFalse: [ ^ self primitiveFail ].

	(self methodHasCogMethod: val) ifFalse: [
		cogit cog: val selector: objectMemory nilObject ].
	
	result := (self methodHasCogMethod: val ) ifTrue: [ objectMemory trueObject ] ifFalse: [ objectMemory falseObject ].

	^ self pop: 1 thenPush: result.