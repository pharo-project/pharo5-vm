interpreter access
changeClassOf: rcvr to: argClass
	"Attempt to change the class of the receiver to the argument given that the
	 format of the receiver matches the format of the argument.  If successful,
	 answer 0, otherwise answer an error code indicating the reason for failure. 
	 Fail if the format of the receiver is incompatible with the format of the argument,
	 or if the argument is a fixed class and the receiver's size differs from the size
	 that an instance of the argument should have."
	<inline: false>
	| classFormat fixedFields instFormat normalizedInstFormat newFormat classIndex |
	(self isObjImmutable: rcvr) ifTrue:
		[^PrimErrNoModification].
	classFormat := self formatOfClass: argClass.
	fixedFields := self fixedFieldsOfClassFormat: classFormat.
	classFormat := self instSpecOfClassFormat: classFormat.
	instFormat := self formatOf: rcvr.
	normalizedInstFormat := self classFormatForInstanceFormat: instFormat.

	"Fail for inability to access classIndex before making contexts snapshot-safe."
	(classIndex := self ensureBehaviorHash: argClass) < 0 ifTrue:
		[^classIndex negated].

	(normalizedInstFormat > self lastPointerFormat
	 and: [normalizedInstFormat = classFormat])
		ifTrue: [newFormat := instFormat]
		ifFalse:
			[normalizedInstFormat <= self lastPointerFormat
				ifTrue:
					[classFormat > self lastPointerFormat ifTrue:
						[^PrimErrInappropriate].
					 (self numSlotsOf: rcvr) < fixedFields ifTrue:
						[^PrimErrBadReceiver].
					 (instFormat = self indexablePointersFormat
					  and: [self isContextNonImm: rcvr]) ifTrue:
						[coInterpreter makeContextSnapshotSafe: rcvr].
					 newFormat := classFormat]
				ifFalse:
					[| instBytes |
					instBytes := self numBytesOf: rcvr.
					normalizedInstFormat caseOf: {
						[self sixtyFourBitIndexableFormat] ->
							[(classFormat < self sixtyFourBitIndexableFormat
							  or: [classFormat >= self firstCompiledMethodFormat]) ifTrue:
								[^PrimErrInappropriate].
							 newFormat := classFormat].
						[self firstLongFormat] ->
							[(classFormat < self sixtyFourBitIndexableFormat
							  or: [classFormat >= self firstCompiledMethodFormat]) ifTrue:
								[^PrimErrInappropriate].
							 (classFormat = self sixtyFourBitIndexableFormat and: [instBytes anyMask: 1]) ifTrue:
								[^PrimErrBadReceiver].
							 newFormat := classFormat].
						[self firstShortFormat] ->
							[(classFormat < self sixtyFourBitIndexableFormat
							  or: [classFormat >= self firstCompiledMethodFormat]) ifTrue:
								[^PrimErrInappropriate].
							 classFormat caseOf: {
								[self sixtyFourBitIndexableFormat]
									-> [(instBytes anyMask: 7) ifTrue: [^PrimErrBadReceiver].
										newFormat := classFormat].
								[self firstLongFormat] 		
									-> [(instBytes anyMask: 3) ifTrue: [^PrimErrBadReceiver].
										newFormat := classFormat + (2 - instBytes bitAnd: 1)].
								[self firstByteFormat] 		
									-> [newFormat := classFormat + (8 - instBytes bitAnd: 7)] }].
						[self firstByteFormat] ->
							[(classFormat < self sixtyFourBitIndexableFormat
							  or: [classFormat >= self firstCompiledMethodFormat]) ifTrue:
								[^PrimErrInappropriate].
							 classFormat caseOf: {
								[self sixtyFourBitIndexableFormat]
									-> [(instBytes anyMask: 7) ifTrue: [^PrimErrBadReceiver].
										newFormat := classFormat].
								[self firstLongFormat] 		
									-> [(instBytes anyMask: 3) ifTrue: [^PrimErrBadReceiver].
										newFormat := classFormat + (2 - instBytes bitAnd: 1)].
								[self firstShortFormat] 		
									-> [(instBytes anyMask: 1) ifTrue: [^PrimErrBadReceiver].
										newFormat := classFormat + (4 - instBytes bitAnd: 3)] }.
							 newFormat := classFormat].
						[self firstCompiledMethodFormat] ->
							[classFormat ~= self firstCompiledMethodFormat ifTrue:
								[^PrimErrInappropriate].
							 newFormat := instFormat] }]].

	self set: rcvr classIndexTo: classIndex formatTo: newFormat.
	"ok"
	^0