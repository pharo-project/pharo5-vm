object format
numFixedSlotsOf: objOop
	<inline: true>
	<asmLabel: false>
	^self fixedFieldsOfClassFormat: (self formatOfClass: (self fetchClassOfNonImm: objOop))