allocation
eeInstantiateMethodContextSlots: numSlots
	<inline: true>
	^self
		allocateSlots: numSlots
		format: self indexablePointersFormat
		classIndex: ClassMethodContextCompactIndex