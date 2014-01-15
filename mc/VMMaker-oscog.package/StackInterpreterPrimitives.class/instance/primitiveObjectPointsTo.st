object access primitives
primitiveObjectPointsTo
	"This primitive is assumed to be fast (see e.g. MethodDictionary>>includesKey:) so make it so.
	 N.B.  Written to use literalHeaderOf: so that in Cog subclasses cogged methods (whose headers
	 point to the machine code method) are still correctly scanned, for the header as well as literals."
	| rcvr thang header fmt lastField methodHeader |
	thang := self stackTop.
	rcvr := self stackValue: 1.
	(objectMemory isIntegerObject: rcvr) ifTrue:
		[^self pop: 2 thenPushBool: false].

	"Inlined version of lastPointerOf: for speed in determining if rcvr is a context."
	header := objectMemory baseHeader: rcvr.
	fmt := objectMemory formatOfHeader: header.
	fmt <= 4
		ifTrue:
			[(fmt = 3
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
					lastField := CtxtTempFrameStart + (self fetchStackPointerOf: rcvr) * BytesPerWord]
				ifFalse:
					[lastField := (objectMemory sizeBitsOfSafe: rcvr) - BaseHeaderSize]]
		ifFalse:
			[fmt < 12 "no pointers" ifTrue:
				[^self pop: 2 thenPushBool: false].
			"CompiledMethod: contains both pointers and bytes:"
			methodHeader := self headerOf: rcvr.
			methodHeader = thang ifTrue: [^self pop: 2 thenPushBool: true].
			lastField := ((self literalCountOfHeader: methodHeader) + 1) * BytesPerWord].

	BaseHeaderSize to: lastField by: BytesPerWord do:
		[:i |
		(self longAt: rcvr + i) = thang ifTrue:
			[^self pop: 2 thenPushBool: true]].
	self pop: 2 thenPushBool: false