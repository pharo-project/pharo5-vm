utilities
arrayValueOf: arrayOop
	"Return the address of first indexable field of resulting array object, or fail if
	 the instance variable does not contain an indexable bytes or words object."
	"Note: May be called by translated primitive code."

	<returnTypeC: #'void *'>
	(objectMemory isWordsOrBytes: arrayOop) ifTrue:
		[^self cCoerceSimple: (self pointerForOop: arrayOop + objectMemory baseHeaderSize) to: #'void *'].
	self primitiveFail