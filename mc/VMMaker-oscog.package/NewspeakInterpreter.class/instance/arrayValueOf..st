utilities
arrayValueOf: arrayOop
	"Return the address of first indexable field of resulting array object, or fail if
	 the instance variable does not contain an indexable bytes or words object."
	"Note: May be called by translated primitive code."

	<returnTypeC: #'void *'>
	((self isNonIntegerObject: arrayOop)
	 and: [self isWordsOrBytes: arrayOop]) ifTrue:
		[^self cCoerceSimple: (self pointerForOop: arrayOop + BaseHeaderSize) to: #'void *'].
	self primitiveFail