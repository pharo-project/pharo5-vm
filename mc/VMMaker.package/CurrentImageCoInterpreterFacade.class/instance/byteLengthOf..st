accessing
byteLengthOf: anOop
	| obj |
	obj := self objectForOop: anOop.
	obj class isBytes ifTrue:
		[^obj basicSize].
	self error: 'cannot determine byte size of argument'