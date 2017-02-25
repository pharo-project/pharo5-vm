object testing
hasPointerFieldsNonImm: oop
	<inline: true>
	^self isAnyPointerFormat: (self formatOf: oop)