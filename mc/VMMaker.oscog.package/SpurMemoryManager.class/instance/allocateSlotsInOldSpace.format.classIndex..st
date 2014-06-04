allocation
allocateSlotsInOldSpace: numSlots format: formatField classIndex: classIndex
	<inline: true>
	^self
		allocateSlotsInOldSpace: numSlots
		bytes: (self objectBytesForSlots: numSlots)
		format: formatField
		classIndex: classIndex