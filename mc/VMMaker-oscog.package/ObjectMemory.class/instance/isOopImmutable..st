header access
isOopImmutable: anOop
	<api>
	^(self isIntegerObject: anOop)
	  or: [self isObjImmutable: anOop]