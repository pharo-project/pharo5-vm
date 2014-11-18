object format
numFixedSlotsOf: objOop
	<inline: true>
	^self fixedFieldsOfClassFormat: (self formatOfClass: (self fetchClassOfNonImm: objOop))