primitives
primitiveAsyncFileWriteResult: fHandle
	| f r |
	<var: #f type: 'AsyncFile *'>
	self primitive: 'primitiveAsyncFileWriteResult' parameters:#(Oop).

	f := self asyncFileValueOf: fHandle.
	interpreterProxy failed ifTrue: [^nil].
	r := self asyncFileWriteResult: f.
	^r asOop: SmallInteger