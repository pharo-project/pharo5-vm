jit - api
unlinkSendsOf: selector isMNUSelector: isMNUSelector
	<api>
	"Unlink all sends in cog methods. Free all Closed PICs with the selector,
	 or with an MNU case if isMNUSelector.  First check if any method actually
	 has the selector; if not there can't be any linked send to it.  This routine
	 (including descendents) is performance critical.  It contributes perhaps
	 30% of entire execution time in Compiler recompileAll."
	| cogMethod mustScanAndUnlink |
	<var: #cogMethod type: #'CogMethod *'>
	methodZoneBase ifNil: [^self].
	cogMethod := self cCoerceSimple: methodZoneBase to: #'CogMethod *'.
	mustScanAndUnlink := false.
	isMNUSelector
		ifTrue:
			[[cogMethod < methodZone limitZony] whileTrue:
				[cogMethod cmType ~= CMFree ifTrue:
					[cogMethod cpicHasMNUCase
						ifTrue:
							[self assert: cogMethod cmType = CMClosedPIC.
							 methodZone freeMethod: cogMethod.
							 mustScanAndUnlink := true]
						ifFalse:
							[cogMethod selector = selector ifTrue:
								[mustScanAndUnlink := true.
								 cogMethod cmType = CMClosedPIC ifTrue:
									[methodZone freeMethod: cogMethod]]]].
				 cogMethod := methodZone methodAfter: cogMethod]]
		ifFalse:
			[[cogMethod < methodZone limitZony] whileTrue:
				[(cogMethod cmType ~= CMFree
				  and: [cogMethod selector = selector]) ifTrue:
					[mustScanAndUnlink := true.
					 cogMethod cmType = CMClosedPIC ifTrue:
						[methodZone freeMethod: cogMethod]].
				 cogMethod := methodZone methodAfter: cogMethod]].
	mustScanAndUnlink ifFalse:
		[^self].
	codeModified := false.
	cogMethod := self cCoerceSimple: methodZoneBase to: #'CogMethod *'.
	[cogMethod < methodZone limitZony] whileTrue:
		[cogMethod cmType = CMMethod ifTrue:
			[self mapFor: cogMethod
				 performUntil: #unlinkIfFreeOrLinkedSend:pc:of:
				 arg: selector].
		cogMethod := methodZone methodAfter: cogMethod].
	codeModified ifTrue: "After possibly updating inline caches we need to flush the icache."
		[processor flushICacheFrom: methodZoneBase asUnsignedInteger to: methodZone limitZony asUnsignedInteger]