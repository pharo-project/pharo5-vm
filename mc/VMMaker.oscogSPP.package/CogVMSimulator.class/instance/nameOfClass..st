debug support
nameOfClass: classOop
	| numSlots maybeThisClassOop maybeNameOop name |
	classNameIndex ifNil: [^'??nil cnidx??'].
	numSlots := objectMemory numSlotsOf: classOop.
	numSlots = metaclassNumSlots ifTrue:
		[maybeThisClassOop := objectMemory fetchPointer: thisClassIndex ofObject: classOop.
		(self addressCouldBeClassObj: maybeThisClassOop) ifTrue:
			[name := self nameOfClass: maybeThisClassOop.
			 (name beginsWith: 'bad ') ifFalse:
				[^name, ' class']].
		 ^'bad class'].
	(numSlots > classNameIndex
	 and: [maybeNameOop := objectMemory fetchPointer: classNameIndex ofObject: classOop.
		objectMemory isBytes: maybeNameOop]) ifFalse:
		[^'bad class'].
	^self stringOf: maybeNameOop