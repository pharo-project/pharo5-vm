primitives
primitiveAsyncFileClose: fh 
	| f |
	<var: #f type: 'AsyncFile *'>
	self primitive: 'primitiveAsyncFileClose' parameters: #(Oop ).
	f := self asyncFileValueOf: fh.
	self asyncFileClose: f