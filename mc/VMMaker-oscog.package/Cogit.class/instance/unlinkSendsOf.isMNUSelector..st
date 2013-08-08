jit - api
unlinkSendsOf: selector isMNUSelector: isMNUSelector
	<api>
	"Unlink all sends in cog methods."
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	methodZoneBase isNil ifTrue: [^self].
	cogMethod := self cCoerceSimple: methodZoneBase to: #'CogMethod *'.
	"First check if any method actually has the selector; if not there can't
	 be any linked send to it."
	[cogMethod < methodZone limitZony
	 and: [cogMethod selector ~= selector]] whileTrue:
		[cogMethod := methodZone methodAfter: cogMethod].
	cogMethod >= methodZone limitZony ifTrue:
		[^nil].
	codeModified := false.
	cogMethod := self cCoerceSimple: methodZoneBase to: #'CogMethod *'.
	[cogMethod < methodZone limitZony] whileTrue:
		[cogMethod cmType = CMMethod
			ifTrue:
				[self mapFor: cogMethod
					 performUntil: #unlinkIfLinkedSend:pc:of:
					 arg: selector]
			ifFalse:
				[(cogMethod cmType ~= CMFree
				  and: [(isMNUSelector and: [cogMethod cpicHasMNUCase])
					or: [cogMethod selector = selector]]) ifTrue:
					[methodZone freeMethod: cogMethod]].
		cogMethod := methodZone methodAfter: cogMethod].
	codeModified ifTrue: "After possibly updating inline caches we need to flush the icache."
		[processor flushICacheFrom: methodZoneBase to: methodZone limitZony asInteger]