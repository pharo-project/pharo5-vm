primitives
primitiveAsyncFileWriteResult: fHandle

	| f r |
	<var: #f type: 'AsyncFile *'>
	self primitive: 'primitiveAsyncFileWriteResult' parameters:#(Oop).

	f := self asyncFileValueOf: fHandle.
	r := self cCode:' asyncFileWriteResult(f)'.
	^r asOop: SmallInteger