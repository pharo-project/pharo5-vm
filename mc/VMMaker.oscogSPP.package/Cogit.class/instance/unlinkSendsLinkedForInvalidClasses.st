jit - api
unlinkSendsLinkedForInvalidClasses
	<api>
	<option: #SpurObjectMemory>
	"Unlink all sends in cog methods whose class tag is that of a forwarded class."
	| cogMethod freedPIC |
	<var: #cogMethod type: #'CogMethod *'>
	methodZoneBase ifNil: [^self].
	cogMethod := self cCoerceSimple: methodZoneBase to: #'CogMethod *'.
	codeModified := freedPIC := false.
	[cogMethod < methodZone limitZony] whileTrue:
		[cogMethod cmType = CMMethod
			ifTrue:
				[self mapFor: cogMethod
					 performUntil: #unlinkIfInvalidClassSend:pc:ignored:
					 arg: 0]
			ifFalse:
				[(cogMethod cmType = CMClosedPIC
				  and: [self cPICHasForwardedClass: cogMethod]) ifTrue:
					[methodZone freeMethod: cogMethod.
					 freedPIC := true]].
		cogMethod := methodZone methodAfter: cogMethod].
	freedPIC
		ifTrue: [self unlinkSendsToFree]
		ifFalse:
			[codeModified ifTrue: "After possibly updating inline caches we need to flush the icache."
				[processor flushICacheFrom: methodZoneBase asUnsignedInteger to: methodZone limitZony asUnsignedInteger]]