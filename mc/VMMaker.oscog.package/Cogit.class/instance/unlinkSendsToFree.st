garbage collection
unlinkSendsToFree
	<api>
	"Unlink all sends in cog methods to free methods and/or pics."
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	methodZoneBase ifNil: [^self].
	codeModified := false.
	cogMethod := self cCoerceSimple: methodZoneBase to: #'CogMethod *'.
	[cogMethod < methodZone limitZony] whileTrue:
		[cogMethod cmType = CMMethod
			ifTrue:
				[self mapFor: cogMethod
					 performUntil: #unlinkIfLinkedSendToFree:pc:ignored:
					 arg: 0]
			ifFalse:
				[cogMethod cmType = CMClosedPIC ifTrue:
					[self assert: (self noTargetsFreeInClosedPIC: cogMethod)]].
		cogMethod := methodZone methodAfter: cogMethod].
	codeModified ifTrue: "After possibly updating inline caches we need to flush the icache."
		[processor flushICacheFrom: methodZoneBase asUnsignedInteger to: methodZone limitZony asUnsignedInteger]