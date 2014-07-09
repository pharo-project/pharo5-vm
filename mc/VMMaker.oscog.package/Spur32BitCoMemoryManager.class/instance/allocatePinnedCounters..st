sista support
allocatePinnedCounters: nCounters
	<api>
	<option: #SistaStackToRegisterMappingCogit>
	^self allocateSlotsForPinningInOldSpace: nCounters
			bytes: (self objectBytesForSlots: nCounters)
			format: self firstLongFormat
			classIndex: 	self thirtyTwoBitLongsClassIndexPun