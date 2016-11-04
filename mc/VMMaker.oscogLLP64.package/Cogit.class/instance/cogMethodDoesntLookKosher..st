debugging
cogMethodDoesntLookKosher: cogMethod
	"Check that the header fields onf a non-free method are consistent with
	 the type. Answer 0 if it is ok, otherwise answer a code for the error."
	<api>
	<inline: false>
	<var: #cogMethod type: #'CogMethod *'>
	((cogMethod blockSize bitAnd: objectMemory wordSize - 1) ~= 0
	 or: [cogMethod blockSize < (self sizeof: CogMethod)
	 or: [cogMethod blockSize >= 32768]]) ifTrue:
		[^1].

	cogMethod cmType = CMFree ifTrue: [^2].

	cogMethod cmType = CMMethod ifTrue:
		[(objectMemory isIntegerObject: cogMethod methodHeader) ifFalse:
			[^11].
		 (objectRepresentation couldBeObject: cogMethod methodObject) ifFalse:
			[^12].
		 (cogMethod stackCheckOffset > 0
		 and: [cogMethod stackCheckOffset < cmNoCheckEntryOffset]) ifTrue:
			[^13].
		 ^0].

	cogMethod cmType = CMOpenPIC ifTrue:
		[cogMethod blockSize ~= openPICSize ifTrue:
			[^21].
		 cogMethod methodHeader ~= 0 ifTrue:
			[^22].
		
		 "Check the nextOpenPIC link unless we're compacting"
		 cogMethod objectHeader >= 0 ifTrue:
			[(cogMethod methodObject ~= 0
			 and: [cogMethod methodObject < methodZoneBase
				   or: [cogMethod methodObject > (methodZone freeStart - openPICSize)
				   or: [(cogMethod methodObject bitAnd: objectMemory wordSize - 1) ~= 0
				   or: [(self cCoerceSimple: cogMethod methodObject
							to: #'CogMethod *') cmType ~= CMOpenPIC]]]]) ifTrue:
				[^23]].
		 cogMethod stackCheckOffset ~= 0 ifTrue:
			[^24].
		 ^0].

	cogMethod cmType = CMClosedPIC ifTrue:
		[cogMethod blockSize ~= closedPICSize ifTrue:
			[^31].
		 (cogMethod cPICNumCases between: 1 and: MaxCPICCases) ifFalse:
			[^32].
		 cogMethod methodHeader ~= 0 ifTrue:
			[^33].
		 cogMethod methodObject ~= 0 ifTrue:
			[^34].
		 ^0].

	^9