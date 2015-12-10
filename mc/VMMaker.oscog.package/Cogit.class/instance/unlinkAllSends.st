jit - api
unlinkAllSends
	<api>
	"Unlink all sends in cog methods."
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	methodZoneBase ifNil: [^self].
	cogMethod := self cCoerceSimple: methodZoneBase to: #'CogMethod *'.
	[cogMethod < methodZone limitZony] whileTrue:
		[cogMethod cmType = CMMethod
			ifTrue:
				[self mapFor: cogMethod
					 performUntil: #unlinkIfLinkedSend:pc:ignored:
					 arg: 0]
			ifFalse:
				[cogMethod cmType ~= CMFree ifTrue:
					[methodZone freeMethod: cogMethod]].
		cogMethod := methodZone methodAfter: cogMethod].
	"After updating inline caches we need to flush the icache."
	processor flushICacheFrom: methodZoneBase asUnsignedInteger to: methodZone limitZony asUnsignedInteger