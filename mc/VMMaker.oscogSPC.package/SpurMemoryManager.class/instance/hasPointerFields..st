object testing
hasPointerFields: oop
	<inline: true>
	^(self isNonImmediate: oop)
	  and: [self hasPointerFieldsNonImm: oop]