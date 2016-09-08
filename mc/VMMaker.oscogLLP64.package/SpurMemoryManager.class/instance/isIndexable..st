object testing
isIndexable: objOop
	| fmt |
	fmt := self formatOf: objOop.
	^self isIndexableFormat: fmt