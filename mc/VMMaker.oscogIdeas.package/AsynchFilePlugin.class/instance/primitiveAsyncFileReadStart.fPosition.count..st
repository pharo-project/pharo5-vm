primitives
primitiveAsyncFileReadStart: fHandle fPosition: fPosition count: count
	| f |
	<var: #f type: 'AsyncFile *'>
	self primitive: 'primitiveAsyncFileReadStart' parameters: #(Oop SmallInteger SmallInteger).
	f := self asyncFileValueOf: fHandle.
	interpreterProxy failed ifTrue: [^nil].
	self asyncFile: f Read: fPosition Start: count