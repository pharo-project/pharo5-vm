jit - api
unlinkSendsTo: targetMethodObject andFreeIf: freeIfTrue
	<api>
	"Unlink all sends in cog methods to a particular target method.
	 If targetMethodObject isn't actually a method (perhaps being
	 used via invokeAsMethod) then there's nothing to do."
	| cogMethod targetMethod freedPIC |
	<var: #cogMethod type: #'CogMethod *'>
	<var: #targetMethod type: #'CogMethod *'>
	((objectMemory isOopCompiledMethod: targetMethodObject)
	and: [coInterpreter methodHasCogMethod: targetMethodObject]) ifFalse:
		[^self].
	targetMethod := coInterpreter cogMethodOf: targetMethodObject.
	methodZoneBase ifNil: [^self].
	codeModified := freedPIC := false.
	cogMethod := self cCoerceSimple: methodZoneBase to: #'CogMethod *'.
	[cogMethod < methodZone limitZony] whileTrue:
		[cogMethod cmType = CMMethod
			ifTrue:
				[self mapFor: cogMethod
					 performUntil: #unlinkIfLinkedSend:pc:to:
					 arg: targetMethod asInteger]
			ifFalse:
				[(cogMethod cmType = CMClosedPIC
				  and: [self cPIC: cogMethod HasTarget: targetMethod]) ifTrue:
					[methodZone freeMethod: cogMethod.
					 freedPIC := true]].
		cogMethod := methodZone methodAfter: cogMethod].
	freeIfTrue ifTrue: [self freeMethod: targetMethod].
	freedPIC
		ifTrue: [self unlinkSendsToFree]
		ifFalse:
			[codeModified ifTrue: "After possibly updating inline caches we need to flush the icache."
				[processor flushICacheFrom: methodZoneBase asUnsignedInteger to: methodZone limitZony asUnsignedInteger]]