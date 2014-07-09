sista support
allocatePinnedCounters: nCounters
	<api>
	<option: #SistaStackToRegisterMappingCogit>
	| numSlots |
	numSlots := nCounters + 1 // 2.
	^self allocateSlotsForPinningInOldSpace: numSlots
			bytes: (self objectBytesForSlots: numSlots)
			format: self firstLongFormat + (nCounters bitAnd: 1)
			classIndex: 	self thirtyTwoBitLongsClassIndexPun