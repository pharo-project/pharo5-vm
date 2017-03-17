primitive support
cStringOrNullFor: oop
	"Answer either a malloced string with the null-terminated contents of oop if oop is a string,
	 or the null pointer if oop is nil, or fail.  It is the client's responsibility to free the string later."
	<api>
	<returnTypeC: #'char *'>
	<inline: false>
	| isString len cString |
	<var: 'cString' type: #'char *'>
	isString := self isInstanceOfClassByteString: oop.
	isString ifFalse:
		[oop ~= objectMemory nilObject ifTrue:
			[self primitiveFailFor: PrimErrBadArgument].
		 ^0].
	len := objectMemory lengthOf: oop.
	len = 0 ifTrue:
		[^0].
	cString := self malloc: len + 1.
	cString ifNil:
		[self primitiveFailFor: PrimErrNoCMemory.
		 ^0].
	self mem: cString cp: (objectMemory firstIndexableField: oop) y: len.
	cString at: (self cCode: [len] inSmalltalk: [len + 1]) put: 0.
	^cString