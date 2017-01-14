become api
become: array1 with: array2 twoWay: twoWayFlag copyHash: copyHashFlag
	"All references to each object in array1 are swapped with all references to the
	 corresponding object in array2. That is, all pointers to one object are replaced
	 with with pointers to the other. The arguments must be arrays of the same length. 
	 Answers PrimNoErr if the primitive succeeds, otherwise a relevant error code."
	"Implementation: Uses lazy forwarding to defer updating references until message send."
	<inline: false>
	| ec |
	self assert: becomeEffectsFlags = 0.
	self runLeakCheckerFor: GCModeBecome.
	(self isArray: array1) ifFalse:
		[^PrimErrBadReceiver].
	((self isArray: array2)
	 and: [(self numSlotsOf: array1) = (self numSlotsOf: array2)]) ifFalse:
		[^PrimErrBadArgument].
	ec := self containsOnlyValidBecomeObjects: array1 and: array2 twoWay: twoWayFlag copyHash: copyHashFlag.
	ec ~= 0 ifTrue:
		[becomeEffectsFlags := 0.
		 ^ec].

	coInterpreter preBecomeAction.
	twoWayFlag
		ifTrue:
			[self innerBecomeObjectsIn: array1 and: array2 copyHash: copyHashFlag]
		ifFalse:
			[self innerBecomeObjectsIn: array1 to: array2 copyHash: copyHashFlag].
	self followSpecialObjectsOop.
	"N.B. perform coInterpreter's postBecomeAction: *before* postBecomeScanClassTable:
	 to allow the coInterpreter to void method cache entries by spotting classIndices that
	 refer to forwarded objects. postBecomeScanClassTable: follows forwarders in the table."
	coInterpreter postBecomeAction: becomeEffectsFlags.
	self postBecomeScanClassTable: becomeEffectsFlags.
	becomeEffectsFlags := 0.

	self assert: self validClassTableHashes.
	self runLeakCheckerFor: GCModeBecome.

	^PrimNoErr "success"