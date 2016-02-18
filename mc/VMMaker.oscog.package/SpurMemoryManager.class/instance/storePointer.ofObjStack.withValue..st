object access
storePointer: fieldIndex ofObjStack: objStackPage withValue: thang
	self assert: (self formatOf: objStackPage) = self wordIndexableFormat.
	self cCode: []
		inSmalltalk:
			[fieldIndex caseOf: {
				[ObjStackTopx]		->	[self assert: (thang between: 0 and: ObjStackLimit)].
				[ObjStackMyx]		->	[self assert: (thang between: MarkStackRootIndex and: MournQueueRootIndex)].
				[ObjStackFreex]	->	[self assert: (thang = 0
														or: [(self addressCouldBeObj: thang)
															and: [(self numSlotsOfAny: thang) = ObjStackPageSlots
															and: [(self formatOf: thang) = self wordIndexableFormat]]])].
				[ObjStackNextx]	->	[self assert: (thang = 0
														or: [(self addressCouldBeObj: thang)
															and: [(self numSlotsOfAny: thang) = ObjStackPageSlots
															and: [(self formatOf: thang) = self wordIndexableFormat]]])]. }
				otherwise: []].
	^self
		longAt: objStackPage + self baseHeaderSize + (fieldIndex << self shiftForWord)
		put: thang