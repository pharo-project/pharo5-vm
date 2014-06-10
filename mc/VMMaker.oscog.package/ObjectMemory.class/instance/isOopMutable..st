header access
isOopMutable: anOop
	<api>
	^(self isIntegerObject: anOop) not
	  and: [(self isObjImmutable: anOop) not]