object access
storePointerImmutabilityCheck: fieldIndex ofObject: objOop withValue: valuePointer
	"Note must check here for stores of young objects into old ones."
	<inline: true> "Must be inlined for the normal send in cannotAssign:to:withIndex:"

	self cppIf: IMMUTABILITY ifTrue: 
		[self deny: (self isImmediate: objOop).
		 (self isImmutable: objOop) ifTrue: 
			[^coInterpreter cannotAssign: valuePointer to: objOop withIndex: fieldIndex]].
	
	^self storePointer: fieldIndex ofObject: objOop withValue: valuePointer