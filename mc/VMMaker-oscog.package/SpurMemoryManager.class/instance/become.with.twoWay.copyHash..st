become api
become: array1 with: array2 twoWay: twoWayFlag copyHash: copyHashFlag
	"All references to each object in array1 are swapped with all references to the
	 corresponding object in array2. That is, all pointers to one object are replaced
	 with with pointers to the other. The arguments must be arrays of the same length. 
	 Answers PrimNoErr if the primitive succeeds, otherwise a relevant error code."
	"Implementation: Uses lazy forwarding to defer updating references until message send."

	self assert: becomeEffectsFlags = 0.
	self leakCheckBecome ifTrue:
		[self runLeakCheckerForFullGC: true].
	(self isArray: array1) ifFalse:
		[^PrimErrBadReceiver].
	((self isArray: array2)
	 and: [(self numSlotsOf: array1) = (self numSlotsOf: array2)]) ifFalse:
		[^PrimErrBadArgument].
	(twoWayFlag or: [copyHashFlag])
		ifTrue: [(self containOnlyOops: array1 and: array2) ifFalse: [^PrimErrInappropriate]]
		ifFalse:
			[(self containOnlyOops: array1) ifFalse: [^PrimErrInappropriate].
			 self followForwardedObjectFields: array2 toDepth: 0].

	coInterpreter preBecomeAction.
	twoWayFlag
		ifTrue:
			[self innerBecomeObjectsIn: array1 with: array2 copyHash: copyHashFlag]
		ifFalse:
			[self innerBecomeObjectsIn: array1 to: array2 copyHash: copyHashFlag].
	self postBecomeScanClassTable.
	coInterpreter postBecomeAction: becomeEffectsFlags.
	becomeEffectsFlags := 0.

	self leakCheckBecome ifTrue:
		[self runLeakCheckerForFullGC: true].

	^PrimNoErr "success"