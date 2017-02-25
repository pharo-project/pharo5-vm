object access
arrayValueOf: oop
	<returnTypeC: 'void *'>
	self success: (self isWordsOrBytes: oop).
	^CArrayAccessor on: oop.