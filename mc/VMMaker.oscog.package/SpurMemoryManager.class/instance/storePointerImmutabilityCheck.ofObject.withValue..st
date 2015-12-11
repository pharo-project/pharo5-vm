object access
storePointerImmutabilityCheck: fieldIndex ofObject: objOop withValue: valuePointer
	"Note must check here for stores of young objects into old ones."
	<inline: true> "normal send in cannotAssign"

	self cppIf: IMMUTABILITY ifTrue: 
		[ self assert: (self isImmediate: objOop) not.
		(self isImmutable: objOop) ifTrue: 
			[ coInterpreter cannotAssign: valuePointer to: objOop withIndex: fieldIndex ] ].
	
	^ self storePointer: fieldIndex ofObject: objOop withValue: valuePointer