other primitives
primitiveGetenv
	"Access to environment variables via getenv.  No putenv or setenv as yet."
	| var result |
	<export: true>
	<var: #var type: #'char *'>
	<var: #result type: #'char *'>
	sHEAFn ~= 0 ifTrue: "secHasEnvironmentAccess"
		[self sHEAFn ifFalse: [^self primitiveFailFor: PrimErrInappropriate]].
	var := self cStringOrNullFor: self stackTop.
	var = 0 ifTrue:
		[self successful ifTrue:
			[^self primitiveFailFor: PrimErrBadArgument].
		 ^self primitiveFailFor: primFailCode].
	result := self getenv: (self cCode: [var] inSmalltalk: [var allButLast]).
	self free: var.
	result ~= 0 ifTrue:
		[result := objectMemory stringForCString: result.
		 result ifNil:
			[^self primitiveFailFor: PrimErrNoMemory]].
	self assert: primFailCode = 0.
	self pop: 2 thenPush: (result = 0 ifTrue: [objectMemory nilObject] ifFalse: [result])