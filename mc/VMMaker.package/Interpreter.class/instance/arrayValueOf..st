utilities
arrayValueOf: arrayOop
	"Return the address of first indexable field of resulting array object, or fail if the instance variable does not contain an indexable bytes or words object."
	"Note: May be called by translated primitive code."

	<returnTypeC: 'void *'>
	((self isIntegerObject: arrayOop) not and:
	 [self isWordsOrBytes: arrayOop])
		ifTrue: [^ self cCode: '(void *)pointerForOop(arrayOop + BaseHeaderSize)'].
	self primitiveFail.
