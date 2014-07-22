sista support
allocatePinnedSlots: nSlots
	<api>
	| obj |
	obj := self allocateSlotsForPinningInOldSpace: nSlots
				bytes: (self objectBytesForSlots: nSlots)
				format: self wordIndexableFormat
				classIndex: 	self wordSizeClassIndexPun.
	obj ifNotNil:
		[self fillObj: obj numSlots: nSlots with: 0].
	^obj