primitives
primitiveAsyncFileReadStart: fHandle fPosition: fPosition count: count
	| f |
	<var: #f type: 'AsyncFile *'>
	self primitive: 'primitiveAsyncFileReadStart' parameters: #(Oop SmallInteger SmallInteger).
	f := self asyncFileValueOf: fHandle.
	self cCode: 'asyncFileReadStart(f, fPosition, count)'
