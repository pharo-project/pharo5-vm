object access primitives
primitiveObjectPointsTo
	"This primitive is assumed to be fast (see e.g. MethodDictionary>>includesKey:) so make it so.
	 N.B.  Written to use literalHeaderOf: so that in Cog subclasses cogged methods (whose headers
	 point to the machine code method) are still correctly scanned, for the header as well as literals."
	| rcvr thang header fmt numSlots methodHeader |
	thang := self stackTop.
	rcvr := self stackValue: 1.
	(objectMemory isImmediate: rcvr) ifTrue:
		[^self pop: 2 thenPushBool: false].

	"Inlined version of lastPointerOf: for speed in determining if rcvr is a context."
	header := objectMemory baseHeader: rcvr.
	fmt := objectMemory formatOfHeader: header.
	(objectMemory isPointersFormat: fmt)
		ifTrue:
			[(fmt = objectMemory indexablePointersFormat
			  and: [objectMemory isContextHeader: header]) 
				ifTrue:
	 				[(self isMarriedOrWidowedContext: rcvr) ifTrue:
						[self externalWriteBackHeadFramePointers.
						 (self isStillMarriedContext: rcvr) ifTrue:
							[^self pop: 2
									thenPushBool: (self marriedContext: rcvr
														pointsTo: thang
														stackDeltaForCurrentFrame: 2)]].
					"contexts end at the stack pointer"
					numSlots := CtxtTempFrameStart + (self fetchStackPointerOf: rcvr)]
				ifFalse:
					[numSlots := objectMemory numSlotsOf: rcvr]]
		ifFalse:
			[fmt < objectMemory firstCompiledMethodFormat "no pointers" ifTrue:
				[^self pop: 2 thenPushBool: false].
			"CompiledMethod: contains both pointers and bytes:"
			methodHeader := self headerOf: rcvr.
			methodHeader = thang ifTrue: [^self pop: 2 thenPushBool: true].
			numSlots := (self literalCountOfHeader: methodHeader) + 1].

	self assert: numSlots - 1 * BytesPerOop + objectMemory baseHeaderSize = (objectMemory lastPointerOf: rcvr).
	objectMemory baseHeaderSize
		to: numSlots - 1 * BytesPerOop + objectMemory baseHeaderSize
		by: BytesPerOop
		do: [:i|
			(self longAt: rcvr + i) = thang ifTrue:
				[^self pop: 2 thenPushBool: true]].
	self pop: 2 thenPushBool: false